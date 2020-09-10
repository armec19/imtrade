$(function () {
    
    $("#file-manager").dxFileManager({
        name: "fileManager",
        fileSystemProvider: fileSystem,
        itemView: {
            mode: "thumbnails"
        },
        height: 450,
        permissions: {
            create: false,
            open: true,
            copy: false,
            move: false,
            delete: true,
            rename: false,
            upload: false,
            download: true
        },
        customizeThumbnail: function(fileSystemItem) {
            if(fileSystemItem.isDirectory)
                return "https://js.devexpress.com/Demos/WidgetsGallery/JSDemos/images/thumbnails/folder.svg";

            const fileExtension = fileSystemItem.getFileExtension();
            switch (fileExtension) {
                case ".txt":
                    return "https://js.devexpress.com/Demos/WidgetsGallery/JSDemos/images/thumbnails/doc-txt.svg";
                case ".rtf":
                    return "https://js.devexpress.com/Demos/WidgetsGallery/JSDemos/images/thumbnails/doc-rtf.svg";
                case ".xml":
                    return "https://js.devexpress.com/Demos/WidgetsGallery/JSDemos/images/thumbnails/doc-xml.svg";
                case ".pdf":
                    return "https://image.flaticon.com/icons/svg/179/179483.svg";    
            }
        }
    });
});

var fileSystem = [
    {
        name: "Documents",
        isDirectory: true,
        items: [
            {
                name: "Projects",
                isDirectory: true,
                items: [
                    {
                        name: "About.rtf",
                        isDirectory: false,
                        size: 1024
                    },
                    {
                        name: "Passwords.rtf",
                        isDirectory: false,
                        size: 2048
                    }
                ]
            },
            {
                name: "About.xml",
                isDirectory: false,
                size: 1024
            },
            {
                name: "Managers.rtf",
                isDirectory: false,
                size: 2048
            },
            {
                name: "ToDo.txt",
                isDirectory: false,
                size: 3072
            }
        ],
    },
    {
        name: "Images",
        isDirectory: true,
        items: [
            {
                name: "logo.png",
                isDirectory: false,
                size: 20480
            },
            {
                name: "banner.gif",
                isDirectory: false,
                size: 10240
            }
        ]
    },
    {
        name: "System",
        isDirectory: true,
        items: [
            {
                name: "Employees.txt",
                isDirectory: false,
                size: 3072
            },
            {
                name: "PasswordList.txt",
                isDirectory: false,
                size: 5120
            }
        ]
    },
    {
        name: "Description.rtf",
        isDirectory: false,
        size: 1024
    },
    {
        name: "Description.txt",
        isDirectory: false,
        size: 2048
    }
    
];