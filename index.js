const fs = require("fs");
const { gitCommitPush } = require("git-commit-push-via-github-api");
process.on("unhandledRejection", console.dir);
if (!process.env.GITHUB_API_TOKEN) {
    throw new Error("GITHUB_API_TOKEN=xxx node example.js");
}
gitCommitPush({
    // commit to https://github.com/azu/commit-to-github-test
    owner: "evandrojr",
    repo: "depot",
    // commit files
    files: [
        { path: "index.js", content: fs.readFileSync(__dirname + "/index.js", "utf-8") },
        // { path: "dir/input.txt", content: fs.readFileSync(__dirname + "/dir/input.txt", "utf-8") },
        // Pass binary as Buffer
        // { path: "next-item.mp3", content: fs.readFileSync(__dirname + "/next-item.mp3") },
        // { path: "image.png", content: fs.readFileSync(__dirname + "/image.png") }
    ],
    fullyQualifiedRef: "heads/master",
    forceUpdate: false, // optional default = false
    commitMessage: "HELLO"
})
    .then(res => {
        console.log("success", res);
    })
    .catch(err => {
        console.error(err);
    });