const express = require("express");
const app = express();
const cors = require("cors");

// Constants
const PORT = 8080;

// Middleware
app.use(cors());

// Requests
// sample get request
app.get("/api", (req, res) => {
    res.json({message: "hello"});
});


// Run the server
app.listen(PORT, () => {
    console.log(`Server running on: ${PORT}`);
});