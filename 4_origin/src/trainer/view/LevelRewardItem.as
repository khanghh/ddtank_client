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
      
      public function setStyle(level:int) : void
      {
         _level = level;
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
         var k:int = 0;
         var it0:* = null;
         var cell0:* = null;
         var j:int = 0;
         var it1:* = null;
         var cell1:* = null;
         if(_item2 != null)
         {
            if(_item2.items.length > 0)
            {
               _levelRewardListII = ComponentFactory.Instance.creatCustomObject("trainer.currentLevel.levelRewardListII");
               for(k = 0; k < _item2.items.length; )
               {
                  it0 = ItemManager.Instance.getTemplateById(int(_item2.items[k]));
                  cell0 = new LevelRewardCell(it0);
                  _levelRewardListII.addCell(cell0);
                  k++;
               }
               addChild(_levelRewardListII);
            }
         }
         if(_item3 != null)
         {
            if(_item3.items.length > 0)
            {
               _levelRewardListIII = ComponentFactory.Instance.creatCustomObject("trainer.currentLevel.levelRewardListIII");
               for(j = 0; j < _item3.items.length; )
               {
                  it1 = ItemManager.Instance.getTemplateById(int(_item3.items[j]));
                  cell1 = new LevelRewardCell(it1);
                  _levelRewardListIII.addCell(cell1);
                  j++;
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
      
      private function __onListOver(event:MouseEvent) : void
      {
         addChild(event.currentTarget as DisplayObject);
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
