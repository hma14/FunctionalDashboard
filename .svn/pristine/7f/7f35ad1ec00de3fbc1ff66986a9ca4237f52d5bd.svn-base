namespace SLTRulesProcess
{
    partial class SLTRulesInstaller
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Component Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.SLTRulesProcessInstaller = new System.ServiceProcess.ServiceProcessInstaller();
            this.SLTRulesServiceInstaller = new System.ServiceProcess.ServiceInstaller();
            // 
            // SLTRulesProcessInstaller
            // 
            this.SLTRulesProcessInstaller.Account = System.ServiceProcess.ServiceAccount.NetworkService;
            this.SLTRulesProcessInstaller.Password = null;
            this.SLTRulesProcessInstaller.Username = null;
            this.SLTRulesProcessInstaller.AfterInstall += new System.Configuration.Install.InstallEventHandler(this.SLTRulesProcessInstaller_AfterInstall);
            // 
            // SLTRulesServiceInstaller
            // 
            this.SLTRulesServiceInstaller.Description = "SLT Rules Processor";
            this.SLTRulesServiceInstaller.DisplayName = "TransLink SLT Rules Processor";
            this.SLTRulesServiceInstaller.ServiceName = "TransLinkSLTRulesProcessor";
            this.SLTRulesServiceInstaller.StartType = System.ServiceProcess.ServiceStartMode.Automatic;
            // 
            // SLTRulesInstaller
            // 
            this.Installers.AddRange(new System.Configuration.Install.Installer[] {
            this.SLTRulesProcessInstaller,
            this.SLTRulesServiceInstaller});

        }

        #endregion

        private System.ServiceProcess.ServiceProcessInstaller SLTRulesProcessInstaller;
        private System.ServiceProcess.ServiceInstaller SLTRulesServiceInstaller;
    }
}