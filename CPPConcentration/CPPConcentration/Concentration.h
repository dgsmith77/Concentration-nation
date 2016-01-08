#pragma once

namespace CPPConcentration 
{
	using namespace System;
	using namespace System::ComponentModel;
	using namespace System::Collections;
	using namespace System::Windows::Forms;
	using namespace System::Data;
	using namespace System::Drawing;
	using namespace System::Resources;
	using namespace System::Reflection;

	/// <summary>
	/// Summary for Concentration
	/// </summary>
	public ref class Concentration : public System::Windows::Forms::Form
	{
	public:
		Concentration(void)
		{
			InitializeComponent();
			//
			//TODO: Add the constructor code here
			//
		}

	protected:
		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		~Concentration()
		{
			if (components)
			{
				delete components;
			}
		}
	private: 
		// constants
		const int totalButtons = 16;
		const int totalPicsAvailable = 50;
		const int delay = 1200;
		String^ defIcon = "face3";
		String^ pictureString = "Bat-icon,Bear-icon,Beaver-icon," +
			"Bee-icon,Bull-icon,Cat-icon,Chicken-icon,Cow-icon,Crab-icon," +
			"Crocodile-icon,Deer-icon,Dog-icon,Dolphin-icon,Duck-icon," +
			"Eagle-icon,Elephant-icon,Fish-icon,Frog-icon,Giraffe-icon," +
			"Goat-icon,Gorilla-icon,Hippo-icon,Horse-icon,Kangaroo-icon," +
			"Koala-icon,Lion-icon,Lizard-icon,Lobster-icon,Monkey-icon," +
			"Mouse-icon,Octopus-icon,Owl-icon,Penguin-icon,Pig-icon," +
			"Rabbit-icon,Raccoon-icon,Rat-icon,Rhino-icon,Seal-icon," +
			"Shark-icon,Sheep-icon,Snail-icon,Snake-icon,Squirrel-icon," +
			"Swan-icon,Tiger-icon,Tuna-icon,Turtle-icon,Whale-icon,Wolf-icon";
		// form elements
		System::Windows::Forms::Panel^  BtnPanel;
		System::Windows::Forms::Label^  lblMoves;
		System::Windows::Forms::Button^  btnStart;
		// variables
		array<String^>^ picset = gcnew array <String^>(totalPicsAvailable);
		array<String^>^ names = gcnew array<String^>(totalButtons);
		array<String^>^ scrambled = gcnew array<String^>(totalButtons);
		array<Button^>^ buttons = gcnew array<Button^>(totalButtons);
		array<Image^>^ images = gcnew array<Image^>(totalButtons);
		int index = 0;
		int prevIndex = -1;
		int uncovered = 0;
		int showing = 0;
		int moves = 0;
		String^ MOVE = " Move";
		String^ MOVES = " Moves";
		/// <summary>
		/// Required designer variable.
		/// </summary>
		System::ComponentModel::Container ^components;
		// resource manager
		ResourceManager^ rm = gcnew System::Resources::ResourceManager(GetType());
		// reflection assembly
		Assembly^ myAssembly = Assembly::GetExecutingAssembly();
		// functions
		System::Void Concentration_Load(System::Object^ sender, System::EventArgs^ e);
		System::Void btnStart_Click(System::Object^ sender, System::EventArgs^ e);
		System::Void ShowMessageBox(String^ message);
		System::Void CreateButtons();
		System::Void ClearArray(array<String^>^ anArray);
		System::Void SelectNames();
		System::Void ScrambleNames();
		System::Void Button_OnClick(System::Object^ sender, System::EventArgs^ e);
		System::Void DoPause();
		System::Void ShowImage(System::Object^ button);
		System::Void ResetButtons();
		
#pragma region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		void InitializeComponent(void)
		{
			System::ComponentModel::ComponentResourceManager^  resources = (gcnew System::ComponentModel::ComponentResourceManager(Concentration::typeid));
			this->BtnPanel = (gcnew System::Windows::Forms::Panel());
			this->lblMoves = (gcnew System::Windows::Forms::Label());
			this->btnStart = (gcnew System::Windows::Forms::Button());
			this->SuspendLayout();
			// 
			// BtnPanel
			// 
			this->BtnPanel->BackColor = System::Drawing::Color::Transparent;
			this->BtnPanel->Location = System::Drawing::Point(20, 33);
			this->BtnPanel->Name = L"BtnPanel";
			this->BtnPanel->Size = System::Drawing::Size(220, 220);
			this->BtnPanel->TabIndex = 0;
			// 
			// lblMoves
			// 
			this->lblMoves->AutoSize = true;
			this->lblMoves->BackColor = System::Drawing::Color::Transparent;
			this->lblMoves->Location = System::Drawing::Point(21, 13);
			this->lblMoves->Name = L"lblMoves";
			this->lblMoves->Size = System::Drawing::Size(48, 13);
			this->lblMoves->TabIndex = 1;
			this->lblMoves->Text = L"0 Moves";
			// 
			// btnStart
			// 
			this->btnStart->Font = (gcnew System::Drawing::Font(L"Microsoft Sans Serif", 8.25F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(0)));
			this->btnStart->Location = System::Drawing::Point(20, 261);
			this->btnStart->Name = L"btnStart";
			this->btnStart->Size = System::Drawing::Size(220, 33);
			this->btnStart->TabIndex = 2;
			this->btnStart->Text = L"Start New Game";
			this->btnStart->UseVisualStyleBackColor = true;
			this->btnStart->Click += gcnew System::EventHandler(this, &Concentration::btnStart_Click);
			// 
			// Concentration
			// 
			this->AutoScaleDimensions = System::Drawing::SizeF(6, 13);
			this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
			this->BackgroundImage = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"$this.BackgroundImage")));
			this->ClientSize = System::Drawing::Size(263, 301);
			this->Controls->Add(this->btnStart);
			this->Controls->Add(this->lblMoves);
			this->Controls->Add(this->BtnPanel);
			this->Name = L"Concentration";
			this->Text = L"C++ Concentration";
			this->Load += gcnew System::EventHandler(this, &Concentration::Concentration_Load);
			this->ResumeLayout(false);
			this->PerformLayout();
		}
#pragma endregion
	};
}
