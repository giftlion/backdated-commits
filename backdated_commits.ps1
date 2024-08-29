# this script creates commits for every second day in 2008 you cant upload to github before 2008....

# Number of commits to create (every second day in 2008)
$NUM_COMMITS = 183  # 365 / 2

# Start date (January 1st, 2008)
$START_DATE = Get-Date "1990-01-01"

# Loop to create commits for every second day in 2008
for ($i = 0; $i -lt $NUM_COMMITS; $i++) {
    # Calculate the date for the commit (every second day)
    $COMMIT_DATE = $START_DATE.AddDays($i * 2)

    # Set the commit date string
    $CommitDateString = $COMMIT_DATE.ToString("yyyy-MM-ddTHH:mm:ss")

    # Modify an existing file (e.g., README.md or any other file)
    $fileName = "README.md"
    if (-not (Test-Path $fileName)) {
        "Initial content" > $fileName
    }

    # Append a comment with the current date to the file
    Add-Content $fileName -Value "`n# Commit on $($COMMIT_DATE.ToString('yyyy-MM-dd'))"

    # Stage the change
    git add $fileName

    # Commit with the specified date using GIT_AUTHOR_DATE and GIT_COMMITTER_DATE
    $env:GIT_AUTHOR_DATE = $CommitDateString
    $env:GIT_COMMITTER_DATE = $CommitDateString
    git commit -m "Backdated commit on $COMMIT_DATE"

    # Clear the environment variables to avoid affecting future commands
    Remove-Item Env:GIT_AUTHOR_DATE
    Remove-Item Env:GIT_COMMITTER_DATE
}