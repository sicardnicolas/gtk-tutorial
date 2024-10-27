text_viewer_sources = [
  'main.vala',
  'application.vala',
  'window.vala',
]

text_viewer_deps = [
  config_dep,
  dependency('gtk4'),
  dependency('libadwaita-1', version: '>= 1.4'),
]

text_viewer_sources += gnome.compile_resources('text-viewer-resources',
  'text-viewer.gresource.xml',
  c_name: 'text_viewer'
)

executable('text-viewer', text_viewer_sources,
  dependencies: text_viewer_deps,
  include_directories: config_inc,
       install: true,
)
