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
      
      public function LevelRewardItem()
      {
         super();
      }
      
      public function setStyle(param1:int) : void
      {
         _level = param1;
         initView();
      }
      
      private function initView() : void
      {
         _item2 = LevelRewardManager.Instance.getRewardInfo(_level,2);
         _item3 = LevelRewardManager.Instance.getRewardInfo(_level,3);
         _bg = ComponentFactory.Instance.creatBitmap("asset.core.levelRewardBg2");
         addChild(_bg);
         currentLevel();
         _txt = ComponentFactory.Instance.creatBitmap("asset.core.levelRewardTxt");
         addChild(_txt);
      }
      
      private function currentLevel() : void
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(_item2 != null)
         {
            if(_item2.items.length > 0)
            {
               _levelRewardListII = ComponentFactory.Instance.creatCustomObject("trainer.currentLevel.levelRewardListII");
               _loc6_ = 0;
               while(_loc6_ < _item2.items.length)
               {
                  _loc4_ = ItemManager.Instance.getTemplateById(int(_item2.items[_loc6_]));
                  _loc3_ = new LevelRewardCell(_loc4_);
                  _levelRewardListII.addCell(_loc3_);
                  _loc6_++;
               }
               addChild(_levelRewardListII);
            }
         }
         if(_item3 != null)
         {
            if(_item3.items.length > 0)
            {
               _levelRewardListIII = ComponentFactory.Instance.creatCustomObject("trainer.currentLevel.levelRewardListIII");
               _loc5_ = 0;
               while(_loc5_ < _item3.items.length)
               {
                  _loc1_ = ItemManager.Instance.getTemplateById(int(_item3.items[_loc5_]));
                  _loc2_ = new LevelRewardCell(_loc1_);
                  _levelRewardListIII.addCell(_loc2_);
                  _loc5_++;
               }
               addChild(_levelRewardListIII);
            }
         }
         addListEvent();
      }
      
      private function addListEvent() : void
      {
         if(_levelRewardListII)
         {
            _levelRewardListII.addEventListener("mouseOver",__onListOver);
         }
         if(_levelRewardListIII)
         {
            _levelRewardListIII.addEventListener("mouseOver",__onListOver);
         }
      }
      
      private function removeListEvent() : void
      {
         if(_levelRewardListII)
         {
            _levelRewardListII.removeEventListener("mouseOver",__onListOver);
         }
         if(_levelRewardListIII)
         {
            _levelRewardListIII.removeEventListener("mouseOver",__onListOver);
         }
      }
      
      private function __onListOver(param1:MouseEvent) : void
      {
         addChild(param1.currentTarget as DisplayObject);
      }
      
      public function dispose() : void
      {
         removeListEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _bg = null;
         if(_levelRewardListII)
         {
            _levelRewardListII.disopse();
            _levelRewardListII = null;
         }
         if(_levelRewardListIII)
         {
            _levelRewardListIII.disopse();
            _levelRewardListIII = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
