package catchInsect
{
   import catchInsect.event.InsectEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.PropInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.BagEvent;
   import ddt.events.FightPropEevnt;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import gameCommon.model.LocalPlayer;
   import gameCommon.view.prop.CustomPropCell;
   import gameCommon.view.prop.FightPropBar;
   import gameCommon.view.prop.PropCell;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   
   public class InsectProBar extends FightPropBar
   {
       
      
      private var _selfInfo:SelfInfo;
      
      private var _type:int;
      
      private var _backStyle:String;
      
      private var _localVisible:Boolean = true;
      
      private var _lock0:Boolean;
      
      private var _lock1:Boolean;
      
      private var _ballTips:Bitmap;
      
      private var _netTips:Bitmap;
      
      public function InsectProBar(self:LocalPlayer, type:int)
      {
         _selfInfo = self.playerInfo as SelfInfo;
         _type = type;
         super(self);
      }
      
      override protected function addEvent() : void
      {
         _selfInfo.PropBag.addEventListener("update",__updateProp);
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var cell in _cells)
         {
            cell.addEventListener("use",__useProp);
         }
         KeyboardManager.getInstance().addEventListener("keyDown",__keyDown);
      }
      
      private function __updateProp(event:BagEvent) : void
      {
         var changes:Dictionary = event.changedSlots;
         var count:int = _selfInfo.PropBag.getItemCountByTemplateId(10615);
         (_cells[0] as CustomPropCell).setCount(count);
         _lock0 = count <= 0;
         _cells[0].enabled = true;
         _cells[0].enabled = !_lock0;
         var count2:int = _selfInfo.PropBag.getItemCountByTemplateId(10616);
         (_cells[1] as CustomPropCell).setCount(count2);
         _lock1 = count2 <= 0;
         _cells[1].enabled = true;
         _cells[1].enabled = !_lock1;
      }
      
      override protected function removeEvent() : void
      {
         _selfInfo.PropBag.removeEventListener("update",__updateProp);
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var cell in _cells)
         {
            cell.removeEventListener("use",__useProp);
         }
         super.removeEvent();
      }
      
      override protected function drawCells() : void
      {
         var pos:* = null;
         var cellz:CustomPropCell = new CustomPropCell("z",_mode,_type);
         pos = ComponentFactory.Instance.creatCustomObject("CustomPropCellPosz");
         cellz.setPossiton(pos.x,pos.y);
         addChild(cellz);
         var cellx:CustomPropCell = new CustomPropCell("x",_mode,_type);
         pos = ComponentFactory.Instance.creatCustomObject("CustomPropCellPosx");
         cellx.setPossiton(pos.x,pos.y);
         addChild(cellx);
         var cellc:CustomPropCell = new CustomPropCell("c",_mode,_type);
         pos = ComponentFactory.Instance.creatCustomObject("CustomPropCellPosc");
         cellc.setPossiton(pos.x,pos.y);
         addChild(cellc);
         _cells.push(cellz);
         _cells.push(cellx);
         _cells.push(cellc);
         drawLayer();
      }
      
      override protected function __keyDown(event:KeyboardEvent) : void
      {
         var _loc2_:* = event.keyCode;
         if(KeyStroke.VK_Z.getCode() !== _loc2_)
         {
            if(KeyStroke.VK_X.getCode() !== _loc2_)
            {
               if(KeyStroke.VK_C.getCode() === _loc2_)
               {
                  _cells[2].useProp();
               }
            }
            else if(_cells[1].enabled)
            {
               _cells[1].useProp();
            }
         }
         else if(_cells[0].enabled)
         {
            _cells[0].useProp();
         }
      }
      
      private function __useProp(event:FightPropEevnt) : void
      {
         var prop:* = null;
         var temp:* = null;
         var result:* = null;
         var propAnimationName:* = null;
         if(_enabled && _localVisible && PropCell(event.currentTarget).enabled)
         {
            prop = PropCell(event.currentTarget).info;
            temp = _selfInfo.FightBag.getItemByTemplateId(prop.Template.TemplateID);
            if(!temp)
            {
               return;
            }
            prop.Place = temp.Place;
            result = _self.useProp(prop,2);
            if(result == "-1")
            {
               if(PropCell(event.currentTarget) == _cells[0])
               {
                  ObjectUtils.disposeObject(_ballTips);
                  _ballTips = null;
               }
               else if(PropCell(event.currentTarget) == _cells[1])
               {
                  if(!PlayerManager.Instance.Self.isCatchInsectGuideFinish(128))
                  {
                     ObjectUtils.disposeObject(_netTips);
                     _netTips = null;
                     SocketManager.Instance.out.syncWeakStep(128);
                     if(!CatchInsectControl.instance.isUnicorn)
                     {
                        _ballTips = ComponentFactory.Instance.creat("catchInsect.useBallTips");
                        LayerManager.Instance.addToLayer(_ballTips,3,false,0,false);
                     }
                  }
               }
               dispatchEvent(new InsectEvent("useProp"));
               enabled = false;
               propAnimationName = EquipType.hasPropAnimation(prop.Template);
               if(propAnimationName != null)
               {
                  _self.showEffect(propAnimationName);
               }
            }
            else if(result != "-1" && result != "0")
            {
               PropCell(event.currentTarget).isUsed = false;
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.prop." + result));
            }
         }
         if(!_enabled)
         {
            PropCell(event.currentTarget).isUsed = false;
         }
      }
      
      override public function enter() : void
      {
         var info:InventoryItemInfo = new InventoryItemInfo();
         info.TemplateID = 10615;
         ItemManager.fill(info);
         var item:ItemTemplateInfo = info as ItemTemplateInfo;
         var prop:PropInfo = new PropInfo(item);
         prop.Place = 0;
         var count:int = _selfInfo.PropBag.getItemCountByTemplateId(10615);
         _cells[0].info = prop;
         (_cells[0] as CustomPropCell).setCount(count);
         _lock0 = count <= 0;
         _cells[0].enabled = true;
         _cells[0].enabled = !_lock0;
         var info2:InventoryItemInfo = new InventoryItemInfo();
         info2.TemplateID = 10616;
         ItemManager.fill(info2);
         var item2:ItemTemplateInfo = info2 as ItemTemplateInfo;
         var prop2:PropInfo = new PropInfo(item2);
         prop2.Place = 1;
         var count2:int = _selfInfo.PropBag.getItemCountByTemplateId(10616);
         _cells[1].info = prop2;
         (_cells[1] as CustomPropCell).setCount(count2);
         _lock1 = count2 <= 0;
         _cells[1].enabled = true;
         _cells[1].enabled = !_lock1;
         if(!PlayerManager.Instance.Self.isCatchInsectGuideFinish(128))
         {
            _netTips = ComponentFactory.Instance.creat("catchInsect.useNetTips");
            LayerManager.Instance.addToLayer(_netTips,3,false,0,false);
         }
         super.enter();
      }
      
      override public function leaving() : void
      {
         ObjectUtils.disposeObject(_netTips);
         _netTips = null;
         ObjectUtils.disposeObject(_ballTips);
         _ballTips = null;
         super.leaving();
      }
      
      public function set backStyle(val:String) : void
      {
         var back:* = null;
         if(_backStyle != val)
         {
            _backStyle = val;
            back = _background;
            _background = ComponentFactory.Instance.creat(_backStyle);
            addChildAt(_background,0);
            ObjectUtils.disposeObject(back);
         }
      }
      
      public function setVisible(val:Boolean) : void
      {
         if(_localVisible != val)
         {
            _localVisible = val;
         }
      }
      
      public function setEnable(value:Boolean) : void
      {
         enabled = value;
         if(_lock0)
         {
            _cells[0].enabled = false;
         }
         if(_lock1)
         {
            _cells[1].enabled = false;
         }
      }
      
      public function showBallTips() : void
      {
         if(PlayerManager.Instance.Self.isCatchInsectGuideFinish(128) && !CatchInsectControl.instance.isUnicorn)
         {
            _ballTips = ComponentFactory.Instance.creat("catchInsect.useBallTips");
            LayerManager.Instance.addToLayer(_ballTips,3,false,0,false);
         }
      }
   }
}
