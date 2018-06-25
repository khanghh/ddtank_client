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
      
      public function SoulPropBar(self:LocalPlayer)
      {
         _soulCells = new Vector.<SoulPropCell>();
         super(self);
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
         for each(var cell in _soulCells)
         {
            cell.removeEventListener("click",__itemClicked);
         }
      }
      
      override public function enter() : void
      {
         setProps();
         updatePropByPsychic();
         super.enter();
      }
      
      private function __psychicChanged(event:LivingEvent) : void
      {
         if(_enabled)
         {
            updatePropByPsychic();
         }
      }
      
      private function __enableChanged(event:LivingEvent) : void
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
         for each(var cell in _soulCells)
         {
            if(cell.info != null && _self.psychic >= cell.info.needPsychic)
            {
               cell.enabled = true;
               showHelpMsg();
            }
            else
            {
               cell.enabled = false;
            }
         }
      }
      
      override protected function drawCells() : void
      {
         var _y:int = 0;
         var _x:int = 0;
         var cell:* = null;
         var count:int = 0;
         var offset:Point = new Point(4,4);
         while(count < 12)
         {
            cell = new SoulPropCell();
            cell.addEventListener("click",__itemClicked);
            _x = count % 6 * (cell.width + 1) + 3.5;
            if(count >= 6)
            {
               _y = cell.height + 2;
            }
            cell.setPossiton(_x + offset.x,_y + offset.y);
            addChild(cell);
            _soulCells.push(cell);
            count++;
         }
      }
      
      override protected function __itemClicked(event:MouseEvent) : void
      {
         var cell:* = null;
         var result:* = null;
         if(_enabled)
         {
            if(_msgShape)
            {
               ObjectUtils.disposeObject(_msgShape);
               _msgShape = null;
            }
            cell = event.currentTarget as SoulPropCell;
            SoundManager.instance.play("008");
            result = _self.useProp(cell.info,1);
            if(result != "-1" && result != "0")
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.prop." + result));
            }
            super.__itemClicked(event);
         }
      }
      
      public function setProps() : void
      {
         var i:int = 0;
         var info:* = null;
         for(i = 0; i < _propDatas.length; )
         {
            info = new PropInfo(ItemManager.Instance.getTemplateById(_propDatas[i]));
            info.Place = -1;
            _soulCells[i].info = info;
            _soulCells[i].enabled = false;
            i++;
         }
      }
      
      public function set props(val:String) : void
      {
         _propDatas = val.split(",");
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
