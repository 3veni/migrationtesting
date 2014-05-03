 @page {
            size: letter;
            margin: 25mm;
            @top-center {
                content: "Sample";
            }
            @bottom-center {
                content: "Page " counter(page) " of " counter(pages);
            }
        }
.page-break {
          background-color:yellow;
        }
        body {
            font-family: Arial Unicode MS;
        }