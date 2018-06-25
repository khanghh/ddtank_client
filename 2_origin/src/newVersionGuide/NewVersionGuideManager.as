package newVersionGuide
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import invite.InviteManager;
   import trainer.view.NewHandContainer;
   
   public class NewVersionGuideManager extends EventDispatcher
   {
      
      private static var _instance:NewVersionGuideManager;
      
      private static var buildingAndIconPosArr:Array = [new Point(626,161),new Point(1100,189),new Point(2006,167),new Point(2195,158),new Point(2235,164),new Point(-312,-107),new Point(-267,-107)];
      
      private static var npcPosArr:Array = [new Point(0,452),new Point(291,133),new Point(466,175),new Point(764,288),new Point(1251,412),new Point(1470,280),new Point(1785,135)];
      
      private static var guideTxtBitmapArr:Array = ["hall.newVersionGuide.dungeon","hall.newVersionGuide.roomList","hall.newVersionGuide.labyrinth","hall.newVersionGuide.farm","hall.newVersionGuide.ringstation","hall.newVersionGuide.email","hall.newVersionGuide.famousPeople"];
      
      private static var _arrowTypeArr:Array = [131,132,133,134,135,136,137];
       
      
      private var _hallView:MovieClip;
      
      private var _paopaoMc:MovieClip;
      
      private var _npcTxt:FilterFrameText;
      
      public var completeGuideFunc:Function;
      
      public var isGuiding:Boolean = false;
      
      public var isShowOldPlayerFrame:Boolean = false;
      
      private var _index:int;
      
      private var _guideSprite:Sprite;
      
      private var _timer:Timer;
      
      public function NewVersionGuideManager(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get instance() : NewVersionGuideManager
      {
         if(_instance == null)
         {
            _instance = new NewVersionGuideManager();
         }
         return _instance;
      }
      
      public function setUp(hallView:MovieClip) : void
      {
         InviteManager.Instance.enabled = false;
         isGuiding = true;
         _hallView = hallView;
         var guideView:NewVersionGuideTipView = new NewVersionGuideTipView(1);
         LayerManager.Instance.addToLayer(guideView,2,true,1);
      }
      
      public function startGuide() : void
      {
         _guideSprite = new Sprite();
         LayerManager.Instance.addToLayer(_guideSprite,2,true,1);
         guide(_index);
      }
      
      private function guide(index:int) : void
      {
         if(_index >= 14)
         {
            dispose();
            return;
         }
         TweenLite.killTweensOf(_hallView);
         if(index < 5)
         {
            TweenLite.to(_hallView,2,{
               "x":-buildingAndIconPosArr[index].x,
               "onComplete":showGuideTxt
            });
         }
         else if(index < 7)
         {
            showGuideTxt();
         }
         else
         {
            TweenLite.to(_hallView,2,{
               "x":-npcPosArr[index - 7].x,
               "onComplete":showGuideTxt
            });
         }
      }
      
      private function showGuideTxt() : void
      {
         if(_index < 5)
         {
            if(_index == 4)
            {
               NewHandContainer.Instance.showArrow(_arrowTypeArr[_index],-135,new Point(160,0),guideTxtBitmapArr[_index],"hall.ringStation.buildingTip.pos",_guideSprite,3000,true);
            }
            else
            {
               NewHandContainer.Instance.showArrow(_arrowTypeArr[_index],180,new Point(0,0),guideTxtBitmapArr[_index],"hall.buildingTip.pos",_guideSprite,3000,true);
            }
         }
         else if(_index < 7)
         {
            NewHandContainer.Instance.showGuideCover("circle",[216,96,46]);
            NewHandContainer.Instance.showArrow(_arrowTypeArr[_index],180,buildingAndIconPosArr[_index],guideTxtBitmapArr[_index],"hall.ringStation.icon.pos" + _index,_guideSprite,0,true);
         }
         else
         {
            if(!_paopaoMc)
            {
               _paopaoMc = ComponentFactory.Instance.creat("ChatBallPaopao");
               _guideSprite.addChild(_paopaoMc);
            }
            else
            {
               _paopaoMc.visible = true;
            }
            if(!_npcTxt)
            {
               _npcTxt = ComponentFactory.Instance.creatComponentByStylename("newVersionGuide.npcTxt");
               _paopaoMc.addChild(_npcTxt);
            }
            else
            {
               _npcTxt.visible = true;
            }
            PositionUtils.setPos(_paopaoMc,"hall.npcPaopao.pos" + _index);
            _npcTxt.text = LanguageMgr.GetTranslation("newVersionGuide.npcTxt" + _index);
         }
         _index = Number(_index) + 1;
         _timer = new Timer(3000);
         _timer.addEventListener("timer",__guideNextHanlder);
         _timer.start();
      }
      
      private function dispose() : void
      {
         var i:int = 0;
         TweenLite.killTweensOf(_hallView);
         _hallView.x = 0;
         for(i = 0; i < _arrowTypeArr.length; )
         {
            NewHandContainer.Instance.clearArrowByID(_arrowTypeArr[i]);
            i++;
         }
         NewHandContainer.Instance.hideGuideCover();
         ObjectUtils.disposeObject(_npcTxt);
         _npcTxt = null;
         _guideSprite.removeChild(_paopaoMc);
         _paopaoMc = null;
         _guideSprite.parent.removeChild(_guideSprite);
         _guideSprite = null;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__guideNextHanlder);
            _timer = null;
         }
         endGuide();
      }
      
      private function endGuide() : void
      {
         InviteManager.Instance.enabled = true;
         isGuiding = false;
         var guideView:NewVersionGuideTipView = new NewVersionGuideTipView(2,completeGuideFunc);
         LayerManager.Instance.addToLayer(guideView,2,true,1);
      }
      
      protected function __guideNextHanlder(event:TimerEvent) : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",__guideNextHanlder);
         }
         if(_paopaoMc && _npcTxt)
         {
            var _loc2_:Boolean = false;
            _npcTxt.visible = _loc2_;
            _paopaoMc.visible = _loc2_;
         }
         guide(_index);
      }
   }
}
