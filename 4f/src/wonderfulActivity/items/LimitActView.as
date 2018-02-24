package wonderfulActivity.items
{
   import activeEvents.data.ActiveEventsInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class LimitActView extends Sprite implements Disposeable
   {
       
      
      private var _info:ActiveEventsInfo;
      
      private var _time:Bitmap;
      
      private var _award:Bitmap;
      
      private var _content:Bitmap;
      
      private var _input:Bitmap;
      
      private var _titleBack:Bitmap;
      
      private var _inputField:TextInput;
      
      private var _timeTitle:FilterFrameText;
      
      private var _awardTitle:FilterFrameText;
      
      private var _contentTitle:FilterFrameText;
      
      private var _timeField:FilterFrameText;
      
      private var _timeWidth:int;
      
      private var _back:MutipleImage;
      
      private var _titleField:FilterFrameText;
      
      private var _line1:Bitmap;
      
      private var _line2:Bitmap;
      
      private var _line3:Bitmap;
      
      private var _awardField:FilterFrameText;
      
      private var _awardWidth:int;
      
      private var _contentField:FilterFrameText;
      
      private var _contentWidth:int;
      
      public function LimitActView(param1:ActiveEventsInfo){super();}
      
      private function initView() : void{}
      
      public function getInputField() : TextInput{return null;}
      
      public function dispose() : void{}
   }
}
