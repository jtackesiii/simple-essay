<#
Based on https://github.com/plain-plain-text/simple-cv/blob/master/process.sh

This PowerShell script processes the files in this repository to generate
a few temporary files and a final pdf and html file for a CV.

If you cannot get this script to run on your local computer, as an initial, security-risky
solution, run this command in Powershell:

Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser

At the end of your work, you can set the policy back to the Windows default:

Set-ExecutionPolicy -ExecutionPolicy Restricted -Scope CurrentUser

Alternatively, you can run powershell itself with different execution policy.
To do that, open a command prompt and run:

powershell -ExecutionPolicy Unrestricted

For the duration of that shell, the policy will be unrestricted.
#>

# 1. Invoke pandoc
"Generating .doc files."
$pandoc_doc_args = @(
    "--standalone",
    "conferences\2020 AAR\om-shanti-emojis-full.md",
    "--filter=pandoc-citeproc",
    "--csl=C:\Users\jtack\Zotero\styles\chicago-author-date.csl",
    "--bibliography=C:\Users\jtack\Zotero\bibs\master.bib",
    "--reference-doc=/Users/jtack/pandoc/custom-reference.docx",
    "--output=_output/om-shanti-emojis.docx"
)
pandoc $pandoc_doc_args
"Files generated."
