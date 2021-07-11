# writeVirtualDubConfiguration -------------------------------------------------
#' Write configuration file for VirtualDub
#'
#' @param outfile outfile
#' @param nFrames nFrames
#'
#' @return Write VirtualDub configuration
#' @export
#'
writeVirtualDubConfiguration <- function
(
  outfile, 
  nFrames
)
{  
  flines <- c(
    "VirtualDub.Open(VirtualDub.params[0]);",
    "VirtualDub.audio.SetSource(0);",
    "VirtualDub.audio.SetMode(0);",
    "VirtualDub.audio.SetInterleave(1,500,1,0,0);",
    "VirtualDub.audio.SetClipMode(1,1);",
    "VirtualDub.audio.SetConversion(0,0,0,0,0);",
    "VirtualDub.audio.SetVolume();",
    "VirtualDub.audio.SetCompression();",
    "VirtualDub.audio.EnableFilterGraph(0);",
    "VirtualDub.video.SetInputFormat(0);",
    "VirtualDub.video.SetOutputFormat(7);",
    "VirtualDub.video.SetMode(3);",
    "VirtualDub.video.SetSmartRendering(0);",
    "VirtualDub.video.SetPreserveEmptyFrames(0);",
    "VirtualDub.video.SetFrameRate2(4,1,1);",
    "VirtualDub.video.SetTargetFrameRate(40000,10000);",
    "VirtualDub.video.SetIVTC(0, 0, 0, 0);",
    "VirtualDub.video.SetCompression(0x64697663,0,10000,0);",
    "VirtualDub.video.SetCompData(4,\"Y29scg==\");",
    "VirtualDub.video.filters.Clear();",
    "VirtualDub.audio.filters.Clear();",
    "VirtualDub.subset.Clear();",
    sprintf("VirtualDub.subset.AddRange(0,%d);", nFrames),
    sprintf("VirtualDub.video.SetRangeFrames(0,%d);", nFrames),
    "VirtualDub.project.ClearTextInfo();",
    "// -- $reloadstop --",
    "VirtualDub.SaveAVI(VirtualDub.params[1]);",
    "VirtualDub.audio.SetSource(1);",
    "VirtualDub.Close();")
  write(flines, outfile)
}

# pngPictureFilesToAviMovieFile ------------------------------------------------
#' Convert png files to avi movie using VirtualDub
#'
#' @param lastPngFile default: dir(tdir, "^wtaqResult", full.names=TRUE)[1]
#' @param tdir default: tempSubdirectory("wtaqResult")
#' @param aviFile default: file.path(tdir, "out.avi")
#' @param virtualDub path to virtualDub executable (default: 
#' system.file("extdata", "VirtualDub", "vdub.exe", package = "kwb.virtualdub"))
#' @param show.avi default: FALSE
#' @return convert png files to avi movie
#' @export
#' @importFrom kwb.utils tempSubdirectory
pngPictureFilesToAviMovieFile <- function  
( 
  lastPngFile = dir(tdir, "^wtaqResult", full.names=TRUE)[1],
  tdir = kwb.utils::tempSubdirectory("wtaqResult"), 
  aviFile = file.path(tdir, "out.avi"),
  virtualDub = system.file("extdata", "VirtualDub", "vdub.exe", package = "kwb.virtualdub"),
  show.avi = FALSE
)
{  
  parts <- strsplit(basename(lastPngFile), split="_")[[1]]
  firstPngFile <- file.path(tdir, sprintf("%s_0001.png", 
                                          paste(rev(rev(parts)[-1]), collapse = "_")))
  cat("first PNG file:", firstPngFile, "\n")
  
  nFrames <- as.integer(strsplit(rev(parts)[1], "\\.")[[1]][1])  
  
  # Write virtualdub script file
  scriptFile <- file.path(tdir, "virtualDub.vcf")
  
  # Write configuration file for VirtualDub in output folder
  writeVirtualDubConfiguration(scriptFile, nFrames)
  
  # Run VirtualDub
  cmdLine = sprintf("\"%s\" /i \"%s\" \"%s\" \"%s\"", 
                    virtualDub, scriptFile, firstPngFile, aviFile)
  cat(cmdLine, "\n")
  system(cmdLine)
  
  if (show.avi) {
    playAviMovieFile(aviFile)
  }
  
  aviFile
}

# playAviMovieFile -------------------------------------------------------------
#' Show AVI file in VLC media player
#'
#' @param avi path to avi file
#'
#' @return shows avi file in VLC media player
#' @export
#' @importFrom utils readRegistry
playAviMovieFile <- function 
(
  avi
)
{
  # Show AVI with VLC media player
  reg <- utils::readRegistry("SOFTWARE\\Classes\\Applications\\vlc.exe\\shell\\Open\\Command")[[1]]
  system(sprintf("%s \"%s\"", sub("\"%1\"", "", reg), avi), wait=FALSE) 
}
