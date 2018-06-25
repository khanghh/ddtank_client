package gameCommon.view.prop
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.EquipType;
   import ddt.data.PropInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.BagEvent;
   import ddt.events.FightPropEevnt;
   import ddt.events.LivingEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import entertainmentMode.view.EntertainmentAlertFrame;
   import flash.display.DisplayObject;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import gameCommon.GameControl;
   import gameCommon.model.LocalPlayer;
   import gameCommon.view.control.SoulState;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   import room.RoomManager;
   
   public class CustomPropBar extends FightPropBar
   {
       
      
      private var _selfInfo:SelfInfo;
      
      private var _type:int;
      
      private var _backStyle:String;
      
      private var _localVisible:Boolean = true;
      
      private var _randomBtn:SimpleBitmapButton;
      
      public function CustomPropBar(self:LocalPlayer, type:int)
      {
         _selfInfo = self.playerInfo as SelfInfo;
         _type = type;
         _randomBtn = ComponentFactory.Instance.creatComponentByStylename("asset.game.custom.random");
         _randomBtn.tipData = LanguageMgr.GetTranslation("ddt.entertainmentMode.cost",ServerConfigManager.instance.entertainmentPrice());
         if(RoomManager.Instance.current.type == 41 && _type != 1 || RoomManager.Instance.current.type == 42)
         {
            addChild(_randomBtn);
         }
         super(self);
      }
      
      override protected function addEvent() : void
      {
         _selfInfo.FightBag.addEventListener("update",__updateProp);
         _self.addEventListener("customenabledChanged",__customEnabledChanged);
         if(_randomBtn)
         {
            _randomBtn.addEventListener("click",__clickHandler);
         }
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var cell in _cells)
         {
            cell.addEventListener("delete",__deleteProp);
            cell.addEventListener("use",__useProp);
         }
         if(_type == 0)
         {
            _self.addEventListener("energyChanged",__energyChange);
         }
         _self.addEventListener("propenabledChanged",__enabledChanged);
         KeyboardManager.getInstance().addEventListener("keyDown",__keyDown);
      }
      
      private function __psychicChanged(event:LivingEvent) : void
      {
         if(_enabled)
         {
            updatePropByPsychic();
         }
      }
      
      private function updatePropByPsychic() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var cell in _cells)
         {
            cell.enabled = cell.info != null && _self.psychic >= cell.info.needPsychic;
         }
      }
      
      override protected function __enabledChanged(event:LivingEvent) : void
      {
         enabled = _self.propEnabled && _self.customPropEnabled;
      }
      
      private function __customEnabledChanged(evt:LivingEvent) : void
      {
         enabled = _self.customPropEnabled;
      }
      
      private function __deleteProp(event:FightPropEevnt) : void
      {
         var cell:PropCell = event.currentTarget as PropCell;
         GameInSocketOut.sendThrowProp(cell.info.Place);
         SoundManager.instance.play("008");
         StageReferance.stage.focus = null;
      }
      
      private function __updateProp(event:BagEvent) : void
      {
         var c:* = null;
         var propInfo:* = null;
         var changes:Dictionary = event.changedSlots;
         var _loc7_:int = 0;
         var _loc6_:* = changes;
         for each(var i in changes)
         {
            c = _selfInfo.FightBag.getItemAt(i.Place);
            if(c)
            {
               propInfo = new PropInfo(c);
               propInfo.Place = c.Place;
               _cells[i.Place].info = propInfo;
            }
            else
            {
               _cells[i.Place].info = null;
            }
         }
      }
      
      private function __clickHandler(e:MouseEvent) : void
      {
         if(ServerConfigManager.instance.entertainmentPrice() > PlayerManager.Instance.Self.DDTMoney)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.entertainmentMode.notEnoughtMoney"));
         }
         else
         {
            SocketManager.Instance.out.buyEntertainment();
         }
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         (evt.target as EntertainmentAlertFrame).removeEventListener("response",__responseHandler);
         (evt.target as EntertainmentAlertFrame).dispose();
         if(evt.responseCode == 2 || evt.responseCode == 3)
         {
            SocketManager.Instance.out.buyEntertainment(true);
         }
      }
      
      override protected function removeEvent() : void
      {
         _selfInfo.FightBag.removeEventListener("update",__updateProp);
         _self.removeEventListener("customenabledChanged",__customEnabledChanged);
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var cell in _cells)
         {
            cell.removeEventListener("delete",__deleteProp);
            cell.removeEventListener("use",__useProp);
         }
         if(_randomBtn)
         {
            _randomBtn.removeEventListener("click",__clickHandler);
            if(_randomBtn.parent)
            {
               _randomBtn.parent.removeChild(_randomBtn);
            }
            _randomBtn.dispose();
         }
         _randomBtn = null;
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
         if(RoomManager.Instance.current && RoomManager.Instance.current.type == 19)
         {
            cellz.isLock = true;
            cellx.isLock = true;
            cellc.isLock = true;
         }
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
            else
            {
               _cells[1].useProp();
            }
         }
         else
         {
            _cells[0].useProp();
         }
      }
      
      private function __useProp(event:FightPropEevnt) : void
      {
         var prop:* = null;
         var result:* = null;
         var propAnimationName:* = null;
         if(_enabled && _localVisible)
         {
            prop = PropCell(event.currentTarget).info;
            result = _self.useProp(prop,2);
            if(result == "-1")
            {
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
         var i:int = 0;
         var info:* = null;
         var propInfo:* = null;
         var bag:BagInfo = _selfInfo.FightBag;
         var len:int = _cells.length;
         for(i = 0; i < len; )
         {
            info = bag.getItemAt(i);
            if(info)
            {
               propInfo = new PropInfo(info);
               propInfo.Place = info.Place;
               _cells[i].info = propInfo;
            }
            else
            {
               _cells[i].info = null;
            }
            i++;
         }
         enabled = _self.customPropEnabled;
         super.enter();
      }
      
      override public function set enabled(val:Boolean) : void
      {
         if(parent is SoulState && GameControl.Instance.Current.togetherShoot)
         {
            val = false;
         }
         .super.enabled = val;
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
   }
}
