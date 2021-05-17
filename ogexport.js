#!/usr/bin/env osascript -l JavaScript
/*
A JXA script for exporting OmniGraffle documents from the commandline

usage: ./ogexport.js <source> <format> <target> <property_1=value_1>...<property_n>=<value_n>

e.g.  ./ogexport.js /Users/beb/dev/ogtool/JXA/test-data/test-data.graffle PNG /Users/beb/tmp/fat scale=2 resolution=3

although scope is not really a "property", it can be still handed in as if it were one.

for some strange reaseon the full path to the og document and for the target is required

Accessing and setting app properties:
OmniGraffle.documents[0].name()
OmniGraffle.documents[0].canvases[0].name.set("foo")
OmniGraffle.currentExportSettings.exportScale()
OmniGraffle.currentExportSettings.areaType()
OmniGraffle.currentExportSettings.areaType.get()

*/

function run (argv) { // eslint-disable-line no-unused-vars
  var parameters = setParameters(argv)

  // open app if not already open
  var appOpened = false
  if (!Application('OmniGraffle').running()) { // eslint-disable-line no-undef
    ObjC.import('AppKit') // eslint-disable-line no-undef
    $.NSWorkspace.sharedWorkspace.launchApplication('/Applications/OmniGraffle.app') // eslint-disable-line no-undef
    // console.log("opening app")
    appOpened = true
  }

  var OmniGraffle = Application('OmniGraffle') // eslint-disable-line no-undef
  OmniGraffle.includeStandardAdditions = true
  // console.log("opening " + parameters.source)
  var doc = OmniGraffle.open(parameters.source)

  // doc.export({as:"PNG", scope:"entire document", to:Path("/Users/beb/tmp/"), withProperties: {scale:1.0, resolution:1.94444441795}})
  doc.export({ as: parameters.format,
    scope: parameters.scope,
    to: Path(parameters.target), // eslint-disable-line no-undef
    withProperties: parameters.properties })

  doc.close()
  if (appOpened) {
    // close app if it was not already open
    OmniGraffle.close()
  }
  console.log('...done')
}

function exportName (filename) {
  if (filename.substr(-8, 8) === '.graffle') {
    return filename.substr(0, filename.length - 8)
  } else {
    return filename.concat('.out')
  }
}

function setParameters (argv) {
  // parse commandline parameters, set default properties

  // console.log(JSON.stringify(argv))
  var source = argv[0]
  var format = argv[1]
  var target = argv[2]
  var myproperties = argv.slice(3)
  console.log('Exporting OmniGraffle document -------------------------------------------')
  console.log('Source: ' + source)
  console.log('Format: ' + format)
  console.log('Target: ' + target)
  console.log('Properties: ' + JSON.stringify(myproperties))

  // set defaults for properties
  var properties = {
    scale: 1.0,
    resolution: 1.94444441795,
    borderamount: 0.0,
    copylinkedimages: true,
    drawsbackground: true, // true for transparent
    readonly: false,
    htmlimagetype: 'PNG',
    includeborder: false,
    includenonprintinglayers: false,
    useartboards: false,
    scope: 'entire document'
  }

  myproperties.forEach(function (element) {
    var res = element.split('=')
    properties[res[0]] = res[1]
  })

  var parameters = {
    source: source,
    format: format,
    scope: properties.scope,
    target: target,
    properties: properties
  }

  var validAreaTypes = ['all graphics', 'current canvas', 'entire document', 'selected graphics']
  var validFormats = ['PNG', 'JPG', 'GIF', 'BMP', 'TIFF', 'PSD', 'OOutline', 'Graffle', 'Visio', 'PDF', 'EPS', 'SVG', 'HTML']

  if (!validAreaTypes.includes(parameters.scope)) {
    throw new Error(`"${parameters.scope}"" is not a valid scope`)
  }
  if (!validFormats.includes(parameters.format)) {
    throw new Error(`"${parameters.format}" is not a valid format`)
  }
  return parameters
}
