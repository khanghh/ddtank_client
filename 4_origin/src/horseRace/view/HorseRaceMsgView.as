package horseRace.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class HorseRaceMsgView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _vbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      public function HorseRaceMsgView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("horseRace.raceView.msgBg");
         addChild(_bg);
         _vbox = ComponentFactory.Instance.creatComponentByStylename("horseRace.race.raceView.msgBox");
         addChild(_vbox);
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("horseRace.race.raceView.msgBoxScroll");
         addChild(_scrollPanel);
         _scrollPanel.setView(_vbox);
         _scrollPanel.invalidateViewport();
      }
      
      private function initEvent() : void
      {
      }
      
      public function addMsg(param1:String) : void
      {
         var _loc2_:FilterFrameText = ComponentFactory.Instance.creat("horseRace.race.matchView.msgTxt");
         _loc2_.mouseEnabled = false;
         _loc2_.htmlText = param1;
         _vbox.addChild(_loc2_);
         _scrollPanel.invalidateViewport(true);
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
      }
   }
}
