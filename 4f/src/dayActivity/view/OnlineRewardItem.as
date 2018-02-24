package dayActivity.view
{
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dayActivity.DayActivityManager;
   import dayActivity.OnlineRewardModel;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class OnlineRewardItem extends Sprite implements Disposeable
   {
       
      
      private var _index:int;
      
      private var _icon:Bitmap;
      
      private var _valueTf:FilterFrameText;
      
      private var _nameTf:FilterFrameText;
      
      private var _getFlag:Bitmap;
      
      private var _model:OnlineRewardModel;
      
      public function OnlineRewardItem(param1:int){super();}
      
      private function initView() : void{}
      
      public function update() : void{}
      
      public function dispose() : void{}
   }
}
