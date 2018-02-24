package exitPrompt
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ExitAllButton extends Component
   {
      
      public static const CHANGE:String = "change";
       
      
      private var _dayMissionBt:ExitButtonItem;
      
      private var _dayMissionSprite:MissionSprite;
      
      private var _actMissionBt:ExitButtonItem;
      
      private var _actMissionSprite:MissionSprite;
      
      private var _emailMissionBt:ExitButtonItem;
      
      private var _bullet1:Bitmap;
      
      private var _bullet2:Bitmap;
      
      private var _bullet3:Bitmap;
      
      private var _viewArr:Array;
      
      private var _model:ExitPromptModel;
      
      private var _dayMissionInfoText:FilterFrameText;
      
      private var _actMissionInfoText:FilterFrameText;
      
      private var _emailMissionInfoText:FilterFrameText;
      
      private var _btNumBg0:ScaleFrameImage;
      
      private var _btNumBg1:ScaleFrameImage;
      
      public var interval:int;
      
      public function ExitAllButton(){super();}
      
      public function start() : void{}
      
      public function get needScorllBar() : Boolean{return false;}
      
      private function _order() : void{}
      
      override public function get height() : Number{return 0;}
      
      private function _addEvt() : void{}
      
      private function _clickDayBt(param1:MouseEvent = null) : void{}
      
      private function _clickActBt(param1:MouseEvent = null) : void{}
      
      private function _textAnalyz0(param1:String, param2:int) : String{return null;}
      
      override public function dispose() : void{}
   }
}
