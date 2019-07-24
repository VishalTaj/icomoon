# Icomoon

[![Gem Version](https://badge.fury.io/rb/icomoon-cli.svg)](https://badge.fury.io/rb/icomoon-cli)

Icomoon gem helps to update icomoon's icons via command line. this gem will automate all the steps to be done while we update icomoon's icon set.

## Installation

    $ gem install icomoon-cli

## Usage

- Open [Iconmoon App](https://icomoon.io/app/#/projects)
- Follow this [Documentation](https://icomoon.io/docs.html) to know how to get started with icomoon.
- Once you have created icon set download the icon set.
- By default this gem assume it's Rails Application hence will be importing to our default rails assets folder and will be keeping a copy of `selection.json` file in our applications **public folder**. if you want to customise the path you can create a file name `.icomoon.yml` add the key value pair as follows in the root of project directory.

```yml
working_directory: /vendor/icofont/tmp
font_directory: /vendor/icofont/fonts
stylesheet_directory: /vendor/icofont/stylesheets
stylesheet: icons.scss
selection_directory: /vendor/icofont/stylesheets
```

- You can either give path for icomoon's generated zip file or you can just give path to the extracted icon set folder.
    
      $ icomoon [path/to/icomoon]


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/VishalTaj/icomoon. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Icomoon project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/icomoon/blob/master/CODE_OF_CONDUCT.md).
