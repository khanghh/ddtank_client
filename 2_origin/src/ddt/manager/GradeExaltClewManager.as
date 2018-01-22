package ddt.manager
{
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.Experience;
   import ddt.data.player.PlayerInfo;
   import ddt.events.DuowanInterfaceEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.RoomCharacter;
   import ddt.view.chat.ChatData;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class GradeExaltClewManager
   {
      
      public static const LIGHT:int = 1;
      
      public static const BLACK:int = 2;
      
      private static var instance:GradeExaltClewManager;
       
      
      private var _asset:MovieClip;
      
      private var _increBlood:String;
      
      private var _grade:int;
      
      private var _character:RoomCharacter;
      
      private var _isSteup:Boolean = false;
      
      private var _info:PlayerInfo;
      
      private var _bloodMovie:Sprite;
      
      public function GradeExaltClewManager()
      {
         super();
      }
      
      public static function getInstance() : GradeExaltClewManager
      {
         if(instance == null)
         {
            instance = new GradeExaltClewManager();
         }
         return instance;
      }
      
      public function setup() : void
      {
         if(_isSteup)
         {
            return;
         }
         addEvent();
         _isSteup = true;
      }
      
      private function addEvent() : void
      {
         PlayerManager.Instance.Self.addEventListener("propertychange",__GradeExalt);
      }
      
      private function removeEvent() : void
      {
         PlayerManager.Instance.Self.removeEventListener("propertychange",__GradeExalt);
      }
      
      private function __GradeExalt(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["Grade"] && PlayerManager.Instance.Self.IsUpGrade && PlayerManager.Instance.Self.Grade > 28)
         {
            DuowanInterfaceManage.Instance.dispatchEvent(new DuowanInterfaceEvent("upGrade"));
            if(param1.target.Grade == _grade)
            {
               return;
            }
            _grade = param1.target.Grade;
            if(StateManager.currentStateType != "fighting")
            {
               show(2);
            }
         }
      }
      
      public function show(param1:int) : void
      {
         CacheSysManager.lock("alertInMovie");
         hide();
         _asset = ComponentFactory.Instance.creat("asset.core.upgradeClewMcOne");
         _asset.addEventListener("enterFrame",__cartoonFrameHandler);
         _asset.gotoAndPlay(1);
         var _loc2_:int = PlayerManager.Instance.Self.Grade;
         _increBlood = _loc2_ == 1?"100":(Experience.getBasicHP(_loc2_) - Experience.getBasicHP(_loc2_ - 1)).toString();
         _bloodMovie = creatNumberMovie();
         PositionUtils.setPos(_bloodMovie,"core.upgradeMoive.pos");
         _asset.leftMC.addChild(_bloodMovie);
         _character = CharactoryFactory.createCharacter(PlayerManager.Instance.Self,"room") as RoomCharacter;
         _character.showGun = false;
         _character.show(false,-1);
         var _loc4_:* = 1.5;
         _character.scaleY = _loc4_;
         _character.scaleX = _loc4_;
         _asset.character.addChild(_character);
         SoundManager.instance.play("063");
         _loc4_ = false;
         _asset.mouseEnabled = _loc4_;
         _loc4_ = _loc4_;
         _asset.mouseChildren = _loc4_;
         _asset.buttonMode = _loc4_;
         if(param1 == 1)
         {
            LayerManager.Instance.addToLayer(_asset,0,false);
         }
         else
         {
            LayerManager.Instance.addToLayer(_asset,0,false,1);
         }
         var _loc3_:ChatData = new ChatData();
         _loc3_.msg = LanguageMgr.GetTranslation("tank.manager.GradeExaltClewManager");
         _loc3_.channel = 6;
         ChatManager.Instance.chat(_loc3_);
      }
      
      private function creatNumberMovie() : Sprite
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:Sprite = new Sprite();
         _loc3_ = 0;
         while(_loc3_ < _increBlood.length)
         {
            _loc2_ = ComponentFactory.Instance.creat("asset.core.upgradeNum_" + _increBlood.charAt(_loc3_));
            _loc2_.x = _loc2_.x + _loc3_ * 20;
            _loc1_.addChild(_loc2_);
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function end() : void
      {
         _asset.gotoAndStop(_asset.totalFrames);
         hide();
      }
      
      private function __cartoonFrameHandler(param1:Event) : void
      {
         if(_asset == null)
         {
            return;
         }
         if(_asset.currentFrame == _asset.totalFrames)
         {
            end();
            CacheSysManager.unlock("alertInMovie");
            CacheSysManager.getInstance().release("alertInMovie",1000);
         }
      }
      
      public function hide() : void
      {
         if(_asset)
         {
            _asset.removeEventListener("enterFrame",__cartoonFrameHandler);
         }
         if(_asset && _asset.parent)
         {
            _asset.parent.removeChild(_asset);
         }
         if(_increBlood)
         {
            ObjectUtils.disposeObject(_increBlood);
         }
         _increBlood = null;
         _asset = null;
         if(_character)
         {
            ObjectUtils.disposeObject(_character);
         }
         _character = null;
      }
   }
}
