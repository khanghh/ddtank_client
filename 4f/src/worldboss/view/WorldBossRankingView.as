package worldboss.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import worldboss.player.RankingPersonInfo;
   
   public class WorldBossRankingView extends Component
   {
       
      
      private var _titleBg:Bitmap;
      
      private var _container:VBox;
      
      public function WorldBossRankingView(){super();}
      
      private function initView() : void{}
      
      public function set rankingInfos(param1:Vector.<RankingPersonInfo>) : void{}
      
      override public function dispose() : void{}
   }
}
