require 'json'

colleges = JSON.parse(File.read('colleges.json'))

#
# Make svg images
#
colleges.each do |college|
  svg = %Q{<?xml version="1.0" encoding="utf-8"?>
<svg version="1.1"
    xmlns="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    width="24" height="24">

    <rect width="24" height="24" x="0" y="0" rx="4" ry="4" style="fill:#{college['secondary']}" />

    <text font-size="16" x="12" y="12" text-anchor="middle">
        <tspan fill="#{college['primary']}" alignment-baseline="central" font-family="serif" font-weight="bold">
            #{college['display']}
        </tspan>
    </text>
</svg>}

  File.open("badges/#{college['domain']}.svg", "w") do |file|
    file.write(svg)
  end
end

#
# Compile README.md
#
File.open("README.md", "w") do |file|
  file.puts "# College Badges"
  file.puts "JSON for creating college badges"
  file.puts
  file.puts "<table>"
  colleges.each do |college|
    file.puts "  <tr>"
      file.puts "    <td><img src='badges/#{college['domain']}.svg'></img></td>"
      file.puts "    <td>#{college['name']}</td>"
      file.puts "    <td>#{college['domain']}</td>"
      file.puts "    <td>#{college['primary']}</td>"
      file.puts "    <td>#{college['secondary']}</td>"
    file.puts "  </tr>"
  end
  file.puts "</table>"
end
