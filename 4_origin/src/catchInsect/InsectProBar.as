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
      
      public function InsectProBar(param1:LocalPlayer, param2:int)
      {
         _selfInfo = param1.playerInfo as SelfInfo;
         _type = param2;
         super(param1);
      }
      
      override protected function addEvent() : void
      {
         _selfInfo.PropBag.addEventListener("update",__updateProp);
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var _loc1_ in _cells)
         {
            _loc1_.addEventListener("use",__useProp);
         }
         KeyboardManager.getInstance().addEventListener("keyDown",__keyDown);
      }
      
      private function __updateProp(param1:BagEvent) : void
      {
         var _loc4_:Dictionary = param1.changedSlots;
         var _loc2_:int = _selfInfo.PropBag.getItemCountByTemplateId(10615);
         (_cells[0] as CustomPropCell).setCount(_loc2_);
         _lock0 = _loc2_ <= 0;
         _cells[0].enabled = true;
         _cells[0].enabled = !_lock0;
         var _loc3_:int = _selfInfo.PropBag.getItemCountByTemplateId(10616);
         (_cells[1] as CustomPropCell).setCount(_loc3_);
         _lock1 = _loc3_ <= 0;
         _cells[1].enabled = true;
         _cells[1].enabled = !_lock1;
      }
      
      override protected function removeEvent() : void
      {
         _selfInfo.PropBag.removeEventListener("update",__updateProp);
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var _loc1_ in _cells)
         {
            _loc1_.removeEventListener("use",__useProp);
         }
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
      
      private function __useProp(param1:FightPropEevnt) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc5_:* = null;
         if(_enabled && _localVisible && PropCell(param1.currentTarget).enabled)
         {
            _loc3_ = PropCell(param1.currentTarget).info;
            _loc4_ = _selfInfo.FightBag.getItemByTemplateId(_loc3_.Template.TemplateID);
            if(!_loc4_)
            {
               return;
            }
            _loc3_.Place = _loc4_.Place;
            _loc2_ = _self.useProp(_loc3_,2);
            if(_loc2_ == "-1")
            {
               if(PropCell(param1.currentTarget) == _cells[0])
               {
                  ObjectUtils.disposeObject(_ballTips);
                  _ballTips = null;
               }
               else if(PropCell(param1.currentTarget) == _cells[1])
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
               _loc5_ = EquipType.hasPropAnimation(_loc3_.Template);
               if(_loc5_ != null)
               {
                  _self.showEffect(_loc5_);
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
         var _loc8_:InventoryItemInfo = new InventoryItemInfo();
         _loc8_.TemplateID = 10615;
         ItemManager.fill(_loc8_);
         var _loc4_:ItemTemplateInfo = _loc8_ as ItemTemplateInfo;
         var _loc6_:PropInfo = new PropInfo(_loc4_);
         _loc6_.Place = 0;
         var _loc3_:int = _selfInfo.PropBag.getItemCountByTemplateId(10615);
         _cells[0].info = _loc6_;
         (_cells[0] as CustomPropCell).setCount(_loc3_);
         _lock0 = _loc3_ <= 0;
         _cells[0].enabled = true;
         _cells[0].enabled = !_lock0;
         var _loc7_:InventoryItemInfo = new InventoryItemInfo();
         _loc7_.TemplateID = 10616;
         ItemManager.fill(_loc7_);
         var _loc1_:ItemTemplateInfo = _loc7_ as ItemTemplateInfo;
         var _loc2_:PropInfo = new PropInfo(_loc1_);
         _loc2_.Place = 1;
         var _loc5_:int = _selfInfo.PropBag.getItemCountByTemplateId(10616);
         _cells[1].info = _loc2_;
         (_cells[1] as CustomPropCell).setCount(_loc5_);
         _lock1 = _loc5_ <= 0;
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
      
      public function setEnable(param1:Boolean) : void
      {
         enabled = param1;
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
