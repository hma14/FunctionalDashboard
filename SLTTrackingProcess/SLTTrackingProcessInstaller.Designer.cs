namespace SLTTrackingProcess
{
    partial class SLTTrackingProcessInstaller
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
            this.SLTTrackingProcessInstaller1 = new System.ServiceProcess.ServiceProcessInstaller();
            this.SLTTrackingInstaller = new System.ServiceProcess.ServiceInstaller();
            // 
            // SLTTrackingProcessInstaller1
            // 
            this.SLTTrackingProcessInstaller1.Account = System.ServiceProcess.ServiceAccount.NetworkService;
            this.SLTTrackingProcessInstaller1.Password = null;
            this.SLTTrackingProcessInstaller1.Username = null;
            // 
            // SLTTrackingInstaller
            // 
            this.SLTTrackingInstaller.Description = "SLT Tracking Processor";
            this.SLTTrackingInstaller.DisplayName = "TransLink SLT Tracking Processor";
            this.SLTTrackingInstaller.ServiceName = "TransLinkSLTTrackingProcessor";
            this.SLTTrackingInstaller.StartType = System.ServiceProcess.ServiceStartMode.Automatic;
            // 
            // SLTTrackingProcessInstaller
            // 
            this.Installers.AddRange(new System.Configuration.Install.Installer[] {
            this.SLTTrackingProcessInstaller1,
            this.SLTTrackingInstaller});

        }

        #endregion

        private System.ServiceProcess.ServiceProcessInstaller SLTTrackingProcessInstaller1;
        private System.ServiceProcess.ServiceInstaller SLTTrackingInstaller;
    }
}