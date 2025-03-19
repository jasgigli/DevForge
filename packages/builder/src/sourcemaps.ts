import * as fs from "fs/promises";
import * as path from "path";

export async function generateSourceMaps(): Promise<void> {
  try {
    const distDir = path.join(process.cwd(), "dist");
    const files = await fs.readdir(distDir);

    for (const file of files) {
      if (file.endsWith(".js") && !file.endsWith(".map")) {
        const mapFile = `${file}.map`;
        const mapPath = path.join(distDir, mapFile);

        // Check if source map exists
        try {
          await fs.access(mapPath);
          console.log(`Source map verified: ${mapFile}`);
        } catch {
          console.warn(`Source map missing for: ${file}`);
        }
      }
    }
  } catch (error) {
    console.error("Source map generation failed:", error);
    throw error;
  }
}
