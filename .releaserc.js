const { execSync } = require("child_process");

const baseBranches = [
  "master",
  { name: "alpha", prerelease: true },
  { name: "beta", prerelease: true },
];

const baseBranchNames = [];
const prerelaseBranches = [];
for (let branch of baseBranches) {
  if (typeof branch === "string") {
    baseBranchNames.push(branch);
  } else {
    baseBranchNames.push(branch.name);
    if (branch.prerelease === true) {
      prerelaseBranches.push(branch);
    }
  }
}

module.exports = {
  ...(process.argv.includes("--dry-run")
    ? {
        branches: (() => {
          const branchName = execSync("git rev-parse --abbrev-ref HEAD")
            .toString()
            .trim();

          if (baseBranchNames.includes(branchName)) {
            return baseBranches;
          } else {
            return [
              {
                name: branchName,
                prerelease: prerelaseBranches.includes(
                  process.env.TARGET_BRANCH || "master"
                ),
              },
            ];
          }
        })(),
      }
    : {
        branches: baseBranches,
      }),
  plugins: [
    "@semantic-release/commit-analyzer",
    "@semantic-release/release-notes-generator",
    "@semantic-release/changelog",
    "@semantic-release/github",
    [
      "@semantic-release/exec",
      {
        verifyConditionsCmd: "./ci/update-pinned-actions.sh -n",
        prepareCmd: "./ci/update-pinned-actions.sh",
      },
    ],
    [
      "@semantic-release/git",
      {
        assets: ["CHANGELOG.md", ".github/workflows/*.yml"],
      },
    ],
    [
      "@semantic-release/exec",
      {
        verifyConditionsCmd: "./ci/update-rolling-tags.sh -n",
        publishCmd: "./ci/update-rolling-tags.sh",
      },
    ],
  ],
};
