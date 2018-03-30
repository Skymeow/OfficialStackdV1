//
//  GetURL.js
//  ShareExtension
//
//  Created by Sky Xu on 3/21/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

var GetURL = function() {};
GetURL.prototype = {
run: function(arguments) {
    arguments.completionFunction({"URL": document.URL});
}
};
var ExtensionPreprocessingJS = new GetURL;

