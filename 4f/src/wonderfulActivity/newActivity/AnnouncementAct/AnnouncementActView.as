package wonderfulActivity.newActivity.AnnouncementAct
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GmActivityInfo;
   import wonderfulActivity.views.IRightView;
   
   public class AnnouncementActView extends Sprite implements IRightView
   {
       
      
      private var _actId:String;
      
      private var _back:DisplayObject;
      
      private var _titleField:FilterFrameText;
      
      private var _buttonBack:DisplayObject;
      
      private var _detailView:AnnouncementDetailView;
      
      private var _activityInfo:GmActivityInfo;
      
      private var _scrollList:ScrollPanel;
      
      private var _content:VBox;
      
      public function AnnouncementActView(param1:String){super();}
      
      public function init() : void{}
      
      private function initView() : void{}
      
      private function initViewWithData() : void{}
      
      private function initData() : void{}
      
      public function setState(param1:int, param2:int) : void{}
      
      public function content() : Sprite{return null;}
      
      public function dispose() : void{}
   }
}
