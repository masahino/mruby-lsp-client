module LSP
  module Parameter
    class TextDocumentItem < Base
      attr_accessor :uri
      LANGUAGE_ID_FILENAME_MAPPING = {
        'Dockerfile' => 'dockerfile', # Dockerfile
        'Makefile' => 'makefile', # Makefile
      }
      LANGUAGE_ID_EXT_MAPPING = {
        '.bat' => 'bat', # Windows Bat
        '.bib' => 'bibtex', # BibTeX
        '.clj' => 'clojure', #Clojure
        '.coffee' => 'coffeescript', #Coffeescript
        '.c' => 'c', # C
        '.cpp' => 'cpp', #C++
        '.cs' => 'csharp', # C#
        '.css' => 'css', # CSS
        '.cxx' => 'cpp', #C++
        '.diff' => 'diff', # Diff
        '.dart' => 'dart', # Dart
        '.fs' => 'fsharp', # F#
        '.go' => 'go', # Go
        '.groovy' => 'groovy', # Groovy
        '.hbs' => 'handlebars', # Handlebars
        '.html' => 'html', # HTML
        '.ini' => 'ini', # Ini
        '.java' => 'java', # Java
        '.js' => 'javascript',# JavaScript
        '.json' => 'json', # JSON
        '.latex' => 'latex', # LaTeX
        '.less' => 'less', # Less
        '.lua' => 'lua', # Lua
        '.md' => 'markdown', # Markdown
        '.m' => 'objective-c', # Objective-C
        '.mm' => 'objective-cpp', # Objective-C++
        '.pl' => 'perl', # Perl
        '.p6' => 'perl6', # Perl 6
        '.php' => 'php', # PHP
        '.ps1' => 'powershell', # Powershell
        '.pug' => 'jade', # Pug
        '.py' => 'python', # Python
        '.r' => 'r', # R
        '.cshtml' => 'razor', # Razor (cshtml)
        '.rb' => 'ruby', # Ruby
        '.rs' => 'rust', # Rust
        '.scss' => 'scss', # Sass (syntax using curly brackets)
        '.sass' => 'sass', # Sass (indented syntax)
        '.scala' => 'scala', # Scala
        '.shader' => 'shaderlab', # ShaderLab
        '.sh' => 'shellscript', # Shell Script (Bash)
        '.sql' => 'sql', # SQL
        '.swift' => 'swift', # Swift
        '.ts' => 'typescript', # TypeScript
        '.tex' => 'tex', # TeX
        '.vb' => 'vb', # Visual Basic
        '.xml' => 'xml', # XML
        '.xsl' => 'xsl', # XSL
        '.yaml' => 'yaml', # YAML
      }
      # Git    git-commit and git-rebase

      def initialize(file_path, language_id = nil, version = nil)
        @uri = 'file://' + File::expand_path(file_path)
        if language_id == nil
          @languageId = guess_lang(file_path)
        end
        if version == nil
          @version = 1
        else
          @version = version
        end
        @text = if File.exist?(file_path) == true
          File.read(file_path)
        else
          ""
        end
      end

      def guess_lang(path)
        ext =  File::extname(path)
        if ext != ""
          LANGUAGE_ID_EXT_MAPPING[ext]
        else
          LANGUAGE_ID_FILENAME_MAPPING[File::basename(path)]
        end
      end
    end
  end
end
