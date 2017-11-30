var cowsay = require("cowsay");

console.log(cowsay.say({text : "lETS CHANGE THE EYES AND ADD A TOUNGE",e : "oO",T : "U "}));
console.log(cowsay.say({text : "Lets kill the cow",e : "XX",T : "U "}));
console.log(cowsay.say({text : "Lets not congigure anyother options for the cow"}));

var jsondata = {"WhoSucks?": "Mike Does","Whodoesnt": "Joe"};
console.log(cowsay.think({
	text : JSON.stringify(jsondata),
	cow: "COW",}));

// or cowsay.think()