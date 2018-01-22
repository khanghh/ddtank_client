package mark.items
{
   import bagAndInfo.cell.BaseCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mark.MarkMgr;
   import mark.data.MarkChipData;
   import mark.data.MarkChipTemplateData;
   import mark.mornUI.items.MarkChipItemUI;
   import mark.views.MarkChipMenu;
   import morn.core.components.Box;
   import morn.core.components.Clip;
   
   public class MarkChipItem extends MarkChipItemUI
   {
       
      
      private var _chip:MarkChipData = null;
      
      private var _cell:BaseCell = null;
      
      private var _active:Boolean = true;
      
      private var _effect:MovieClip = null;
      
      private var _effectContainer:Sprite = null;
      
      public function MarkChipItem(param1:MarkChipData)
      {
         _chip = param1;
         super();
      }
      
      override protected function initialize() : void
      {
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:* = null;
         tipDirctions = "7,6,2,1,5,4,0,3,6";
         tipGapV = 10;
         tipGapH = 10;
         if(!_chip)
         {
            dispose();
            return;
         }
         var _loc4_:MarkChipTemplateData = MarkMgr.inst.model.cfgChip[_chip.templateId];
         if(!_loc4_)
         {
            return;
         }
         var _loc2_:Array = [[startBox11,startBox12,startBox13,startBox14,startBox15],[startBox21,startBox22,startBox23,startBox24,startBox25],[startBox31,startBox32,startBox33,startBox34,startBox35],[startBox41,startBox42,startBox43,startBox44,startBox45],[startBox51,startBox52,startBox53,startBox54,startBox55],[startBox61,startBox62,startBox63,startBox64,startBox65]];
         var _loc3_:Boolean = false;
         var _loc1_:Clip = null;
         _loc8_ = 0;
         while(_loc8_ < _loc2_.length)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc2_[_loc8_].length)
            {
               _loc3_ = _loc8_ + 1 == _loc4_.Place && _loc6_ + 1 == _chip.bornLv + _chip.hammerLv;
               _loc2_[_loc8_][_loc6_].visible = _loc3_;
               if(_loc3_)
               {
                  _loc7_ = 0;
                  while(_loc7_ <= _loc6_)
                  {
                     _loc1_ = (_loc2_[_loc8_][_loc6_] as Box).getChildAt(_loc7_) as Clip;
                     if(_loc1_)
                     {
                        _loc1_.index = _loc7_ < _chip.bornLv?0:1;
                     }
                     _loc7_++;
                  }
               }
               _loc6_++;
            }
            _loc8_++;
         }
         if(!_cell)
         {
            _loc5_ = new Shape();
            _loc5_.graphics.beginFill(16777215,0);
            _loc5_.graphics.drawRect(0,0,80,80);
            _loc5_.graphics.endFill();
            _cell = new BaseCell(_loc5_);
            _cell.setContentSize(80,80);
            itemBox.addChild(_cell);
            _cell.addEventListener("interactive_click",clickHander);
            _cell.addEventListener("interactive_double_click",doubleClickHandler);
            DoubleClickManager.Instance.enableDoubleClick(_cell);
         }
         _cell.info = ItemManager.Instance.getTemplateById(_loc4_.Id);
         _cell.tipData = null;
         _cell.mouseEnabled = false;
      }
      
      protected function doubleClickHandler(param1:InteractiveEvent) : void
      {
         if(!_active)
         {
            return;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         param1.stopImmediatePropagation();
      }
      
      private function clickHander(param1:InteractiveEvent) : void
      {
         if(_chip.itemID == 0 || !_active)
         {
            return;
         }
         var _loc2_:MarkChipMenu = new MarkChipMenu(_chip.itemID);
         var _loc3_:Point = _cell.parent.localToGlobal(new Point(_cell.x,_cell.y));
         _loc2_.x = _loc3_.x + 30;
         _loc2_.y = _loc3_.y + 30;
         LayerManager.Instance.addToLayer(_loc2_,2);
         param1.stopImmediatePropagation();
      }
      
      public function set interactive(param1:Boolean) : void
      {
         _active = param1;
      }
      
      public function playSuitEffect() : void
      {
         var _loc1_:Array = [0,0,180,0,180,0,180];
         var _loc3_:Array = ["","","","asset.mark.blueEffect","asset.mark.purpleEffect","asset.mark.goldEffect"];
         var _loc2_:MarkChipTemplateData = MarkMgr.inst.model.cfgChip[_chip.templateId];
         if(!_loc2_ || _loc3_[_loc2_.Character].length == 0)
         {
            return;
         }
         if(!_effect)
         {
            _effect = ComponentFactory.Instance.creat(_loc3_[_loc2_.Character]);
            var _loc4_:Boolean = false;
            _effect.mouseEnabled = _loc4_;
            _effect.mouseChildren = _loc4_;
            if(!_effectContainer)
            {
               _effectContainer = new Sprite();
               addChild(_effectContainer);
               _effectContainer.addChild(_effect);
               _loc4_ = false;
               _effectContainer.mouseEnabled = _loc4_;
               _effectContainer.mouseChildren = _loc4_;
               PositionUtils.setPos(_effect,{
                  "x":-_effect.width / 2,
                  "y":-_effect.height / 2
               });
            }
            _effectContainer.rotation = _loc1_[_loc2_.Place];
            PositionUtils.setPos(_effectContainer,_effectContainer.rotation != 180?"mark.suitEffectPos1":"mark.suitEffectPos2");
         }
         if(_effect)
         {
            _effect.play();
         }
      }
      
      public function stopSuitEffect() : void
      {
         if(_effect)
         {
            _effect.stop();
            ObjectUtils.disposeObject(_effect);
         }
         if(_effectContainer)
         {
            ObjectUtils.disposeObject(_effectContainer);
         }
         _effect = null;
         _effectContainer = null;
      }
      
      public function get id() : int
      {
         return !!_chip?_chip.itemID:0;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_effect)
         {
            ObjectUtils.disposeObject(_effect);
         }
         _effect = null;
         if(_effectContainer)
         {
            ObjectUtils.disposeObject(_effectContainer);
         }
         _effectContainer = null;
         ObjectUtils.disposeAllChildren(this);
         if(_cell)
         {
            _cell.removeEventListener("interactive_click",clickHander);
            _cell.removeEventListener("interactive_double_click",doubleClickHandler);
            ObjectUtils.disposeObject(_cell);
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
