Radiant Super Export Extension
===

About
---

An extension by [Aissac][ai] that provides portability to your [Radiant CMS][rd] project by allowing you to export and import the records in the database and making it easy to manage them with a source control tool like Git or Subversion.

Features
---
* All records are exported to individual YAML files;
* A directory is created for each model in the default import/export path which is db/export;
* The individual YAML files are saved with the record ID as their filename.

Installation
---

The [Super Export Extension][rse] has no dependencies, so all you have to do is install it:
  
    git submodule add git://github.com/Aissac/radiant-super-export-extension.git vendor/extensions/super_export

Usage
---

To export, use:
  
    rake db:super_export

To import, use:

    rake db:super_import
    
### Working example

Exporting the Page model looks like this:

    db/
      export/
        pages/
          1.yml
          2.yml
          3.yml
          ...

Contributors
---

* Istvan Hoka
* Cristi Duma

[ai]: http://www.aissac.ro/
[rd]: http://radiantcms.org/
[rse]: http://blog.aissac.ro/radiant/super-export-extension/