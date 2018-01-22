package team.view.mornui.TeamChat
{
   import morn.core.components.Button;
   import morn.core.components.Label;
   import morn.core.components.List;
   import morn.core.components.TextArea;
   import morn.core.components.TextInput;
   import morn.core.components.View;
   
   public class TeamChatUI extends View
   {
       
      
      public var minBtn:Button = null;
      
      public var closeBtn:Button = null;
      
      public var showRecordBtn:Button = null;
      
      public var sendBtn:Button = null;
      
      public var teamText1:Label = null;
      
      public var teamText2:Label = null;
      
      public var textInput:TextInput = null;
      
      public var outputText:TextArea = null;
      
      public var member_list:List = null;
      
      public function TeamChatUI(){super();}
      
      override protected function createChildren() : void{}
   }
}
