#include "Concentration.h"
#include <iostream>

#using <mscorlib.dll>
#using <system.windows.forms.dll>

using namespace System;
using namespace System::Windows::Forms;
using namespace System::Threading;
using namespace System::Reflection;
using namespace System::IO;
using namespace System::Collections;
using namespace System::Globalization;
using namespace System::Resources;

namespace CPPConcentration
{
	[STAThread]
	void main(array<String^>^ args)
	{
		Application::EnableVisualStyles();
		Application::SetCompatibleTextRenderingDefault(false);
		CPPConcentration::Concentration concentration;
		Application::Run(%concentration);
	}

	void Concentration::Concentration_Load(System::Object^ sender, System::EventArgs^ e)
	{
		picset = pictureString->Split(',');
		CreateButtons();	// create the buttons on the first pass
		ClearArray(names);
		ClearArray(scrambled);
		SelectNames();
		ScrambleNames();
	}

	void Concentration::btnStart_Click(System::Object^ sender, System::EventArgs^ e)
	{
		ResetButtons();		// reset the buttons after the first pass
		ClearArray(names);
		ClearArray(scrambled);
		SelectNames();
		ScrambleNames();

		// reset the variables
		moves = 0;
		index = 0;
		prevIndex = -1;
		uncovered = 0;
		showing = 0;
		lblMoves->Text = "0 Moves";
	}

	void Concentration::CreateButtons()
	{
		int cx = BtnPanel->ClientRectangle.Width / 4;
		int cy = BtnPanel->ClientRectangle.Height / 4;
		for (int row = 0; row < 4; row++)
		{
			for (int col = 0; col < 4; col++)
			{
				try
				{
					int index = col * 4 + row;
					buttons[index] = gcnew Button();
					AssemblyName^ assemblyName = myAssembly->GetName();
					ResourceManager^ rm = gcnew ResourceManager(assemblyName->Name + ".Resource", myAssembly);
					Bitmap^ img = (Bitmap^)rm->GetObject(defIcon);
					img->Tag = defIcon;
					buttons[index]->Image = img;
					buttons[index]->Click += gcnew EventHandler(this, &Concentration::Button_OnClick);
					buttons[index]->Tag = index.ToString();
					buttons[index]->SetBounds(cx * row, cy * col, cx, cy);
					BtnPanel->Controls->Add(buttons[index]);
				}
				catch (Exception^ ex)
				{
					ShowMessageBox("An error occurred: " + ex->Message + "\nStack Trace:\n" + ex->StackTrace);
				}
			}
		}
	}

	void Concentration::ClearArray(array<String^>^ anArray)
	{
		for (int i = 0; i < anArray->Length; i++)
		{
			anArray[i] = String::Empty;
		}
	}
	void Concentration::SelectNames()
	{
		Random^ generator = gcnew Random();
		String^ usedIndices = "";
		int i = 0;
		int j;
		do
		{
			j = generator->Next(totalPicsAvailable);
			if (names[i] == String::Empty && !usedIndices->Contains("_" + j))
			{
				usedIndices += "_" + j;
				names[i] = picset[j];
				names[i + 8] = picset[j];
				i++;
			}
		} while (i <= 7);
	}

	void Concentration::ScrambleNames()
	{
		Random^ generator = gcnew Random();
		int i = 0;
		int j;
		do
		{
			j = generator->Next(16);
			if (scrambled[j] == "")
			{
				scrambled[j] = names[i];
				i++;
			}
		} while (i <= 15);
	}

	void Concentration::Button_OnClick(System::Object^ sender, System::EventArgs^ e)
	{
		// start a new thread so the images will be uncovered when the DoPause kicks in
		Thread^ ShowImgThread = gcnew Thread(gcnew ParameterizedThreadStart(this, &Concentration::ShowImage));
		ShowImgThread->Start(sender);
		ShowImgThread->Join();

		// check for matches
		if (showing % 2 == 0 && showing != uncovered)
		{
			// update moves
			String^ strmoves = moves == 0 ? ++moves + MOVE : ++moves + MOVES;
			lblMoves->Text = strmoves;

			// check for a match
			if (scrambled[prevIndex] == scrambled[index])
			{
				uncovered += 2;
			}
			else
			{
				// pause for 1 second
				DoPause();

				// cover up the images with the default
				AssemblyName^ assemblyName = myAssembly->GetName();
				ResourceManager^ rm = gcnew ResourceManager(assemblyName->Name + ".Resource", myAssembly);
				Bitmap^ defaultImage = (Bitmap^)rm->GetObject(defIcon);
				defaultImage->Tag = defIcon;
				buttons[prevIndex]->Image = defaultImage;
				buttons[index]->Image = defaultImage;
			}
		}
		// update indices
		prevIndex = index;
	}

	void Concentration::ShowImage(System::Object^ button)
	{
		// get the button that was clicked
		Button^ btn = cli::safe_cast<System::Windows::Forms::Button^>(button);
		// get image to show
		index = Convert::ToInt32(btn->Tag);
		AssemblyName^ assemblyName = myAssembly->GetName();
		ResourceManager^ rm = gcnew ResourceManager(assemblyName->Name + ".Resource", myAssembly);
		Bitmap^ img = (Bitmap^)rm->GetObject(scrambled[index]);
		btn->Image = img;

		// check for images that aren't the default
		// to prevent double clicking
		showing = 0;
		for (int i = 0; i < buttons->Length; i++)
		{
			showing += buttons[i]->Image->Tag == defIcon ? 0 : 1;
		}
	}

	void Concentration::DoPause()
	{
		AutoResetEvent^ are = gcnew AutoResetEvent(false);
		are->WaitOne(delay, true);
	}

	// function to reset the default image to all buttons
	void Concentration::ResetButtons()
	{
		// reset the default image
		for (int i = 0; i < buttons->Length; i++)
		{
			AssemblyName^ assemblyName = myAssembly->GetName();
			ResourceManager^ rm = gcnew ResourceManager(assemblyName->Name + ".Resource", myAssembly);
			Bitmap^ img = (Bitmap^)rm->GetObject(defIcon);
			img->Tag = defIcon;
			buttons[i]->Image = img;
		}
	}

	// used this mainly for debugging/testing
	void Concentration::ShowMessageBox(String^ message)
	{
		MessageBox::Show(message);
	}
}