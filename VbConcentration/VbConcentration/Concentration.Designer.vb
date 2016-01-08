<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Concentration
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.lblMoves = New System.Windows.Forms.Label()
        Me.btnPanel = New System.Windows.Forms.Panel()
        Me.btnStart = New System.Windows.Forms.Button()
        Me.SuspendLayout()
        '
        'lblMoves
        '
        Me.lblMoves.AutoSize = True
        Me.lblMoves.BackColor = System.Drawing.Color.Transparent
        Me.lblMoves.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblMoves.Location = New System.Drawing.Point(12, 9)
        Me.lblMoves.Name = "lblMoves"
        Me.lblMoves.Size = New System.Drawing.Size(55, 13)
        Me.lblMoves.TabIndex = 0
        Me.lblMoves.Text = "0 Moves"
        '
        'btnPanel
        '
        Me.btnPanel.Location = New System.Drawing.Point(12, 26)
        Me.btnPanel.Name = "btnPanel"
        Me.btnPanel.Size = New System.Drawing.Size(220, 220)
        Me.btnPanel.TabIndex = 1
        '
        'btnStart
        '
        Me.btnStart.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.btnStart.Location = New System.Drawing.Point(12, 253)
        Me.btnStart.Name = "btnStart"
        Me.btnStart.Size = New System.Drawing.Size(220, 37)
        Me.btnStart.TabIndex = 2
        Me.btnStart.Text = "Start New Game"
        Me.btnStart.UseVisualStyleBackColor = True
        '
        'Concentration
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackgroundImage = Global.VbConcentration.My.Resources.Resources.zoo_lighter
        Me.ClientSize = New System.Drawing.Size(243, 299)
        Me.Controls.Add(Me.btnStart)
        Me.Controls.Add(Me.btnPanel)
        Me.Controls.Add(Me.lblMoves)
        Me.Name = "Concentration"
        Me.Text = "VB Concentration"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents lblMoves As System.Windows.Forms.Label
    Friend WithEvents btnPanel As System.Windows.Forms.Panel
    Friend WithEvents btnStart As System.Windows.Forms.Button

End Class
