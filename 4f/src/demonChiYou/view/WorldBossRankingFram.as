package demonChiYou.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import worldboss.player.RankingPersonInfo;
   
   public class WorldBossRankingFram extends BaseAlerFrame
   {
      
      public static var _rankingPersons:Array = [];
       
      
      private var titleLineBg:MutipleImage;
      
      private var titleBg:MovieImage;
      
      private var numTitle:FilterFrameText;
      
      private var nameTitle:FilterFrameText;
      
      private var souceTitle:FilterFrameText;
      
      private var _sureBtn:TextButton;
      
      public function WorldBossRankingFram(){super();}
      
      private function __onCoreiLoaded(param1:UIModuleEvent) : void{}
      
      public function _init() : void{}
      
      public function addPersonRanking(param1:RankingPersonInfo) : void{}
      
      public function show() : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      private function __sureBtnClick(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
