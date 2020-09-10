<div id="prive">
    <link rel="stylesheet" href="../assets/node_modules/html5-editor/bootstrap-wysihtml5.css" />
    <link href="../assets/node_modules/dropzone-master/dist/dropzone.css" rel="stylesheet" type="text/css" />
    <link href="../dist/css/pages/inbox.css" rel="stylesheet">
    <div class="row page-titles">
        <div class="col-md-5 align-self-center">
            <h4 class="text-themecolor">Composer</h4>
        </div>
        <div class="col-md-7 align-self-center text-right">
            <div class="d-flex justify-content-end align-items-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">e-Mails</a></li>
                    <li class="breadcrumb-item active">Composer</li>
                </ol> 
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="row">
                    <div class="col-xlg-2 col-lg-3 col-md-4 ">
                        <div class="card-body inbox-panel"><a href="app-compose.html" class="btn btn-danger m-b-20 p-10 btn-block waves-effect waves-light">Compose</a>
                            <ul class="list-group list-group-full">
                                <li class="list-group-item active"> <a href="javascript:void(0)"><i class="mdi mdi-gmail"></i> Inbox </a><span class="badge badge-success ml-auto">6</span></li>
                                <li class="list-group-item">
                                    <a href="javascript:void(0)"> <i class="mdi mdi-star"></i> Starred </a>
                                </li>
                                <li class="list-group-item">
                                    <a href="javascript:void(0)"> <i class="mdi mdi-send"></i> Draft </a><span class="badge badge-danger ml-auto">3</span></li>
                                <li class="list-group-item ">
                                    <a href="javascript:void(0)"> <i class="mdi mdi-file-document-box"></i> Sent Mail </a>
                                </li>
                                <li class="list-group-item">
                                    <a href="javascript:void(0)"> <i class="mdi mdi-delete"></i> Trash </a>
                                </li>
                            </ul>
                            <h3 class="card-title m-t-40">Labels</h3>
                            <div class="list-group b-0 mail-list"> <a href="javascript:void(0)" class="list-group-item"><span class="fa fa-circle text-info m-r-10"></span>Work</a> <a href="javascript:void(0)" class="list-group-item"><span class="fa fa-circle text-warning m-r-10"></span>Family</a> <a href="javascript:void(0)" class="list-group-item"><span class="fa fa-circle text-purple m-r-10"></span>Private</a> <a href="javascript:void(0)" class="list-group-item"><span class="fa fa-circle text-danger m-r-10"></span>Friends</a> <a href="javascript:void(0)" class="list-group-item"><span class="fa fa-circle text-success m-r-10"></span>Corporate</a> </div>
                        </div>
                    </div>
                    <div class="col-xlg-10 col-lg-9 col-md-8 bg-light border-left">
                        <div class="card-body">
                            <h3 class="card-title">Compose New Message</h3>
                            <div class="form-group">
                                <input class="form-control" placeholder="To:">
                            </div>
                            <div class="form-group">
                                <input class="form-control" placeholder="Subject:">
                            </div>
                            <div class="form-group">
                                <textarea class="textarea_editor form-control" rows="15" placeholder="Enter text ..."></textarea>
                            </div>
                            <h4><i class="ti-link"></i> Attachment</h4>
                            <form action="#" class="dropzone">
                                <div class="fallback">
                                    <input name="file" type="file" multiple />
                                </div>
                            </form>
                            <button type="submit" class="btn btn-success m-t-20"><i class="fa fa-envelope-o"></i> Send</button>
                            <button class="btn btn-dark m-t-20"><i class="fa fa-times"></i> Discard</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
     
</div>