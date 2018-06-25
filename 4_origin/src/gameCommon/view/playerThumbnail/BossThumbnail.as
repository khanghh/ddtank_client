package gameCommon.view.playerThumbnail
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.events.LivingEvent;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.BitmapFilter;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import gameCommon.model.Living;
   import gameCommon.model.SimpleBoss;
   import room.RoomManager;
   import worldboss.WorldBossManager;
   import worldboss.event.WorldBossRoomEvent;
   import worldboss.view.WorldBossCutHpMC;
   
   public class BossThumbnail extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _living:Living;
      
      private var _headFigure:HeadFigure;
      
      private var _blood:BossBloodItem;
      
      private var _name:FilterFrameText;
      
      private var lightingFilter:BitmapFilter;
      
      public function BossThumbnail(living:Living)
      {
         super();
         _living = living;
         init();
         initEvents();
      }
      
      public function init() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.game.bossThumbnailBgAsset");
         addChild(_bg);
         _headFigure = new HeadFigure(62,62,_living);
         addChild(_headFigure);
         _headFigure.y = 11;
         _headFigure.x = 4;
         if(RoomManager.Instance.current.type == 14)
         {
            _blood = new BossBloodItem(WorldBossManager.Instance.bossInfo.total_Blood);
            WorldBossManager.Instance.addEventListener("boss_hp_updata",__showCutHp);
            _blood.bloodNum = WorldBossManager.Instance.bossInfo.current_Blood;
         }
         else
         {
            _blood = new BossBloodItem(_living.maxBlood);
            __updateBlood(null);
         }
         addChild(_blood);
         var p:Point = ComponentFactory.Instance.creatCustomObject("room.bossThumbnailHPPos");
         _blood.x = p.x;
         _blood.y = p.y;
         _name = ComponentFactory.Instance.creatComponentByStylename("asset.game.bossThumbnailNameTxt");
         addChild(_name);
         _name.text = _living.name;
      }
      
      public function initEvents() : void
      {
         if(_living)
         {
            _living.addEventListener("bloodChanged",__updateBlood);
            _living.addEventListener("die",__die);
         }
      }
      
      public function __updateBlood(evt:LivingEvent) : void
      {
         if(RoomManager.Instance.current.type != 14)
         {
            _blood.bloodNum = _living.blood;
         }
         if(_living.blood <= 0)
         {
            if(_headFigure)
            {
               _headFigure.gray();
            }
         }
      }
      
      public function __die(evt:LivingEvent) : void
      {
         if(_headFigure)
         {
            _headFigure.gray();
         }
         if(_blood)
         {
            _blood.visible = false;
         }
      }
      
      private function __shineChange(evt:LivingEvent) : void
      {
         var boss:SimpleBoss = _living as SimpleBoss;
         if(boss && boss.isAttacking)
         {
         }
      }
      
      public function setUpLintingFilter() : void
      {
         var matrix:Array = [];
         matrix = matrix.concat([1,0,0,0,25]);
         matrix = matrix.concat([0,1,0,0,25]);
         matrix = matrix.concat([0,0,1,0,25]);
         matrix = matrix.concat([0,0,0,1,0]);
         lightingFilter = new ColorMatrixFilter(matrix);
      }
      
      public function removeEvents() : void
      {
         if(_living)
         {
            _living.removeEventListener("bloodChanged",__updateBlood);
            _living.removeEventListener("die",__die);
         }
      }
      
      public function updateView() : void
      {
         if(!_living)
         {
            this.visible = false;
         }
         else
         {
            if(_headFigure)
            {
               _headFigure.dispose();
               _headFigure = null;
            }
            if(_blood)
            {
               _blood = null;
            }
            init();
         }
      }
      
      public function set info(value:Living) : void
      {
         if(!value)
         {
            removeEvents();
         }
         _living = value;
         updateView();
      }
      
      public function get Id() : int
      {
         if(!_living)
         {
            return -1;
         }
         return _living.LivingID;
      }
      
      private function __showCutHp(e:WorldBossRoomEvent) : void
      {
         if(WorldBossManager.Instance.bossInfo.cutValue <= 0)
         {
            return;
         }
         if(_blood)
         {
            _blood.updateBlood(WorldBossManager.Instance.bossInfo.current_Blood,WorldBossManager.Instance.bossInfo.total_Blood);
         }
         var numMC:WorldBossCutHpMC = new WorldBossCutHpMC(WorldBossManager.Instance.bossInfo.cutValue);
         PositionUtils.setPos(numMC,"fightBoss.numMC.pos");
         addChildAt(numMC,0);
      }
      
      private function offset(off:int = 30) : int
      {
         var i:int = Math.random() * 10;
         if(i % 2 == 0)
         {
            return -(int(Math.random() * off));
         }
         return int(Math.random() * off);
      }
      
      public function dispose() : void
      {
         removeEvents();
         removeChild(_bg);
         _bg.bitmapData.dispose();
         _bg = null;
         _living = null;
         _headFigure.dispose();
         _headFigure = null;
         _blood.dispose();
         _blood = null;
         _name.dispose();
         _name = null;
         lightingFilter = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
