package gameCommon.view.prop
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.PropInfo;
   import ddt.events.LivingEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import gameCommon.model.LocalPlayer;
   
   public class SoulPropBar extends FightPropBar
   {
       
      
      protected var _soulCells:Vector.<SoulPropCell>;
      
      private var _propDatas:Array;
      
      private var _back:DisplayObject;
      
      private var _msgShape:DisplayObject;
      
      private var _lockScreen:DisplayObject;
      
      public function SoulPropBar(param1:LocalPlayer)
      {
         _soulCells = new Vector.<SoulPropCell>();
         super(param1);
      }
      
      override protected function configUI() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.game.prop.SoulBack");
         addChild(_back);
         _lockScreen = ComponentFactory.Instance.creatBitmap("asset.game.PsychicBar.LockScreen");
         addChild(_lockScreen);
         super.configUI();
      }
      
      override protected function addEvent() : void
      {
         _self.addEventListener("psychicChanged",__psychicChanged);
         _self.addEventListener("soulPropEnableChanged",__enableChanged);
      }
      
      override protected function removeEvent() : void
      {
         _self.removeEventListener("psychicChanged",__psychicChanged);
         _self.removeEventListener("soulPropEnableChanged",__enableChanged);
         var _loc3_:int = 0;
         var _loc2_:* = _soulCells;
         for each(var _loc1_ in _soulCells)
         {
            _loc1_.removeEventListener("click",__itemClicked);
         }
      }
      
      override public function enter() : void
      {
         setProps();
         updatePropByPsychic();
         super.enter();
      }
      
      private function __psychicChanged(param1:LivingEvent) : void
      {
         if(_enabled)
         {
            updatePropByPsychic();
         }
      }
      
      private function __enableChanged(param1:LivingEvent) : void
      {
         enabled = _self.soulPropEnabled;
         if(_enabled)
         {
            updatePropByPsychic();
         }
      }
      
      private function showHelpMsg() : void
      {
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(300) && !PlayerManager.Instance.Self.IsWeakGuildFinish(301))
         {
            if(_msgShape == null)
            {
               _msgShape = ComponentFactory.Instance.creatBitmap("asset.game.ghost.msg2");
               _msgShape.y = -_msgShape.height;
               addChild(_msgShape);
            }
            SocketManager.Instance.out.syncWeakStep(301);
         }
      }
      
      private function updatePropByPsychic() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _soulCells;
         for each(var _loc1_ in _soulCells)
         {
            if(_loc1_.info != null && _self.psychic >= _loc1_.info.needPsychic)
            {
               _loc1_.enabled = true;
               showHelpMsg();
            }
            else
            {
               _loc1_.enabled = false;
            }
         }
      }
      
      override protected function drawCells() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc5_:Point = new Point(4,4);
         while(_loc3_ < 12)
         {
            _loc4_ = new SoulPropCell();
            _loc4_.addEventListener("click",__itemClicked);
            _loc1_ = _loc3_ % 6 * (_loc4_.width + 1) + 3.5;
            if(_loc3_ >= 6)
            {
               _loc2_ = _loc4_.height + 2;
            }
            _loc4_.setPossiton(_loc1_ + _loc5_.x,_loc2_ + _loc5_.y);
            addChild(_loc4_);
            _soulCells.push(_loc4_);
            _loc3_++;
         }
      }
      
      override protected function __itemClicked(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(_enabled)
         {
            if(_msgShape)
            {
               ObjectUtils.disposeObject(_msgShape);
               _msgShape = null;
            }
            _loc3_ = param1.currentTarget as SoulPropCell;
            SoundManager.instance.play("008");
            _loc2_ = _self.useProp(_loc3_.info,1);
            if(_loc2_ != "-1" && _loc2_ != "0")
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.prop." + _loc2_));
            }
            super.__itemClicked(param1);
         }
      }
      
      public function setProps() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < _propDatas.length)
         {
            _loc1_ = new PropInfo(ItemManager.Instance.getTemplateById(_propDatas[_loc2_]));
            _loc1_.Place = -1;
            _soulCells[_loc2_].info = _loc1_;
            _soulCells[_loc2_].enabled = false;
            _loc2_++;
         }
      }
      
      public function set props(param1:String) : void
      {
         _propDatas = param1.split(",");
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_lockScreen);
         _lockScreen = null;
      }
   }
}
