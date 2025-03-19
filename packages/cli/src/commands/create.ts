export async function createProject(projectName: string, options: { template?: string }): Promise<void> {
    console.log(`Creating new project: ${projectName}`);
    console.log('Template:', options.template || 'default');
    // Implementation will come later
}