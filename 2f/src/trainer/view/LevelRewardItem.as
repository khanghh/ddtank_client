package trainer.view
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import trainer.controller.LevelRewardManager;
   import trainer.data.LevelRewardInfo;
   
   public class LevelRewardItem extends Sprite
   {
       
      
      private var _level:int;
      
      private var _bg:Bitmap;
      
      private var _txt:Bitmap;
      
      private var _item2:LevelRewardInfo;
      
      private var _item3:LevelRewardInfo;
      
      private var _levelRewardListII:LevelRewardList;
      
      private var _levelRewardListIII:LevelRewardList;
      
      public function LevelRewardItem(){super();}
      
      public function setStyle(param1:int) : void{}
      
      private function initView() : void{}
      
      private function currentLevel() : void{}
      
      private function addListEvent() : void{}
      
      private function removeListEvent() : void{}
      
      private function __onListOver(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
