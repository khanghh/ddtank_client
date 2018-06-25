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
      
      public function MarkChipItem(chip:MarkChipData)
      {
         _chip = chip;
         super();
      }
      
      override protected function initialize() : void
      {
         var i:int = 0;
         var j:int = 0;
         var k:int = 0;
         var cellBG:* = null;
         tipDirctions = "7,6,2,1,5,4,0,3,6";
         tipGapV = 10;
         tipGapH = 10;
         if(!_chip)
         {
            dispose();
            return;
         }
         var chipTemplate:MarkChipTemplateData = MarkMgr.inst.model.cfgChip[_chip.templateId];
         if(!chipTemplate)
         {
            return;
         }
         var stars:Array = [[startBox11,startBox12,startBox13,startBox14,startBox15],[startBox21,startBox22,startBox23,startBox24,startBox25],[startBox31,startBox32,startBox33,startBox34,startBox35],[startBox41,startBox42,startBox43,startBox44,startBox45],[startBox51,startBox52,startBox53,startBox54,startBox55],[startBox61,startBox62,startBox63,startBox64,startBox65]];
         var active:Boolean = false;
         var clip:Clip = null;
         for(i = 0; i < stars.length; )
         {
            for(j = 0; j < stars[i].length; )
            {
               active = i + 1 == chipTemplate.Place && j + 1 == _chip.bornLv + _chip.hammerLv;
               stars[i][j].visible = active;
               if(active)
               {
                  for(k = 0; k <= j; )
                  {
                     clip = (stars[i][j] as Box).getChildAt(k) as Clip;
                     if(clip)
                     {
                        clip.index = k < _chip.bornLv?0:1;
                     }
                     k++;
                  }
               }
               j++;
            }
            i++;
         }
         if(!_cell)
         {
            cellBG = new Shape();
            cellBG.graphics.beginFill(16777215,0);
            cellBG.graphics.drawRect(0,0,80,80);
            cellBG.graphics.endFill();
            _cell = new BaseCell(cellBG);
            _cell.setContentSize(80,80);
            itemBox.addChild(_cell);
            _cell.addEventListener("interactive_click",clickHander);
            _cell.addEventListener("interactive_double_click",doubleClickHandler);
            DoubleClickManager.Instance.enableDoubleClick(_cell);
         }
         _cell.info = ItemManager.Instance.getTemplateById(chipTemplate.Id);
         _cell.tipData = null;
         _cell.mouseEnabled = false;
      }
      
      protected function doubleClickHandler(e:InteractiveEvent) : void
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
         e.stopImmediatePropagation();
      }
      
      private function clickHander(evt:InteractiveEvent) : void
      {
         if(_chip.itemID == 0 || !_active)
         {
            return;
         }
         var menu:MarkChipMenu = new MarkChipMenu(_chip.itemID);
         var pos:Point = _cell.parent.localToGlobal(new Point(_cell.x,_cell.y));
         menu.x = pos.x + 30;
         menu.y = pos.y + 30;
         LayerManager.Instance.addToLayer(menu,2);
         evt.stopImmediatePropagation();
      }
      
      public function set interactive(value:Boolean) : void
      {
         _active = value;
      }
      
      public function playSuitEffect() : void
      {
         var angles:Array = [0,0,180,0,180,0,180];
         var effectStr:Array = ["","","","asset.mark.blueEffect","asset.mark.purpleEffect","asset.mark.goldEffect"];
         var chipTemplate:MarkChipTemplateData = MarkMgr.inst.model.cfgChip[_chip.templateId];
         if(!chipTemplate || effectStr[chipTemplate.Character].length == 0)
         {
            return;
         }
         if(!_effect)
         {
            _effect = ComponentFactory.Instance.creat(effectStr[chipTemplate.Character]);
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
            _effectContainer.rotation = angles[chipTemplate.Place];
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
