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
      
      public function CustomPropBar(param1:LocalPlayer, param2:int)
      {
         _selfInfo = param1.playerInfo as SelfInfo;
         _type = param2;
         _randomBtn = ComponentFactory.Instance.creatComponentByStylename("asset.game.custom.random");
         _randomBtn.tipData = LanguageMgr.GetTranslation("ddt.entertainmentMode.cost",ServerConfigManager.instance.entertainmentPrice());
         if(RoomManager.Instance.current.type == 41 && _type != 1 || RoomManager.Instance.current.type == 42)
         {
            addChild(_randomBtn);
         }
         super(param1);
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
         for each(var _loc1_ in _cells)
         {
            _loc1_.addEventListener("delete",__deleteProp);
            _loc1_.addEventListener("use",__useProp);
         }
         if(_type == 0)
         {
            _self.addEventListener("energyChanged",__energyChange);
         }
         _self.addEventListener("propenabledChanged",__enabledChanged);
         KeyboardManager.getInstance().addEventListener("keyDown",__keyDown);
      }
      
      private function __psychicChanged(param1:LivingEvent) : void
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
         for each(var _loc1_ in _cells)
         {
            _loc1_.enabled = _loc1_.info != null && _self.psychic >= _loc1_.info.needPsychic;
         }
      }
      
      override protected function __enabledChanged(param1:LivingEvent) : void
      {
         enabled = _self.propEnabled && _self.customPropEnabled;
      }
      
      private function __customEnabledChanged(param1:LivingEvent) : void
      {
         enabled = _self.customPropEnabled;
      }
      
      private function __deleteProp(param1:FightPropEevnt) : void
      {
         var _loc2_:PropCell = param1.currentTarget as PropCell;
         GameInSocketOut.sendThrowProp(_loc2_.info.Place);
         SoundManager.instance.play("008");
         StageReferance.stage.focus = null;
      }
      
      private function __updateProp(param1:BagEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc5_:Dictionary = param1.changedSlots;
         var _loc7_:int = 0;
         var _loc6_:* = _loc5_;
         for each(var _loc4_ in _loc5_)
         {
            _loc2_ = _selfInfo.FightBag.getItemAt(_loc4_.Place);
            if(_loc2_)
            {
               _loc3_ = new PropInfo(_loc2_);
               _loc3_.Place = _loc2_.Place;
               _cells[_loc4_.Place].info = _loc3_;
            }
            else
            {
               _cells[_loc4_.Place].info = null;
            }
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
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
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         (param1.target as EntertainmentAlertFrame).removeEventListener("response",__responseHandler);
         (param1.target as EntertainmentAlertFrame).dispose();
         if(param1.responseCode == 2 || param1.responseCode == 3)
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
         for each(var _loc1_ in _cells)
         {
            _loc1_.removeEventListener("delete",__deleteProp);
            _loc1_.removeEventListener("use",__useProp);
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
         var _loc4_:* = null;
         var _loc3_:CustomPropCell = new CustomPropCell("z",_mode,_type);
         _loc4_ = ComponentFactory.Instance.creatCustomObject("CustomPropCellPosz");
         _loc3_.setPossiton(_loc4_.x,_loc4_.y);
         addChild(_loc3_);
         var _loc2_:CustomPropCell = new CustomPropCell("x",_mode,_type);
         _loc4_ = ComponentFactory.Instance.creatCustomObject("CustomPropCellPosx");
         _loc2_.setPossiton(_loc4_.x,_loc4_.y);
         addChild(_loc2_);
         var _loc1_:CustomPropCell = new CustomPropCell("c",_mode,_type);
         _loc4_ = ComponentFactory.Instance.creatCustomObject("CustomPropCellPosc");
         _loc1_.setPossiton(_loc4_.x,_loc4_.y);
         addChild(_loc1_);
         _cells.push(_loc3_);
         _cells.push(_loc2_);
         _cells.push(_loc1_);
         if(RoomManager.Instance.current && RoomManager.Instance.current.type == 19)
         {
            _loc3_.isLock = true;
            _loc2_.isLock = true;
            _loc1_.isLock = true;
         }
         drawLayer();
      }
      
      override protected function __keyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:* = param1.keyCode;
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
      
      private function __useProp(param1:FightPropEevnt) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         if(_enabled && _localVisible)
         {
            _loc3_ = PropCell(param1.currentTarget).info;
            _loc2_ = _self.useProp(_loc3_,2);
            if(_loc2_ == "-1")
            {
               _loc4_ = EquipType.hasPropAnimation(_loc3_.Template);
               if(_loc4_ != null)
               {
                  _self.showEffect(_loc4_);
               }
            }
            else if(_loc2_ != "-1" && _loc2_ != "0")
            {
               PropCell(param1.currentTarget).isUsed = false;
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.prop." + _loc2_));
            }
         }
         if(!_enabled)
         {
            PropCell(param1.currentTarget).isUsed = false;
         }
      }
      
      override public function enter() : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc1_:BagInfo = _selfInfo.FightBag;
         var _loc3_:int = _cells.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _loc1_.getItemAt(_loc5_);
            if(_loc4_)
            {
               _loc2_ = new PropInfo(_loc4_);
               _loc2_.Place = _loc4_.Place;
               _cells[_loc5_].info = _loc2_;
            }
            else
            {
               _cells[_loc5_].info = null;
            }
            _loc5_++;
         }
         enabled = _self.customPropEnabled;
         super.enter();
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(parent is SoulState && GameControl.Instance.Current.togetherShoot)
         {
            param1 = false;
         }
         .super.enabled = param1;
      }
      
      public function set backStyle(param1:String) : void
      {
         var _loc2_:* = null;
         if(_backStyle != param1)
         {
            _backStyle = param1;
            _loc2_ = _background;
            _background = ComponentFactory.Instance.creat(_backStyle);
            addChildAt(_background,0);
            ObjectUtils.disposeObject(_loc2_);
         }
      }
      
      public function setVisible(param1:Boolean) : void
      {
         if(_localVisible != param1)
         {
            _localVisible = param1;
         }
      }
   }
}
