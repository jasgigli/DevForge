import { Command } from "commander";
import { createProject } from "./commands/create";
import { startDev } from "./commands/dev";
import { build } from "./commands/build";

const program = new Command();

program
  .name("devforge")
  .description("Modern development toolkit")
  .version("0.1.0-beta");

program
  .command("new <project-name>")
  .description("Create a new project")
  .option("-t, --template <template>", "project template")
  .action(createProject);

program.command("dev").description("Start development server").action(startDev);

program.command("build").description("Build for production").action(build);

export function run(): void {
  program.parse(process.argv);
}
