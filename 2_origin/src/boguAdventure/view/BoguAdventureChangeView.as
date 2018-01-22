package boguAdventure.view
{
   import bagAndInfo.cell.CellContentCreator;
   import boguAdventure.BoguAdventureControl;
   import boguAdventure.player.BoguAdventurePlayer;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.SoundManager;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class BoguAdventureChangeView extends Sprite implements Disposeable
   {
      
      public static const MINE:String = "mine";
      
      public static const SIGN:String = "sign";
       
      
      private var _bogu:BoguAdventurePlayer;
      
      private var _control:BoguAdventureControl;
      
      private var _list:Dictionary;
      
      private var _move:Boolean;
      
      private var _explodeAction:MovieClip;
      
      private var _awardAction:MovieClip;
      
      private var _mineNum:ScaleFrameImage;
      
      private var _awardImgae:CellContentCreator;
      
      private var _boguDie:Bitmap;
      
      public function BoguAdventureChangeView(param1:BoguAdventureControl)
      {
         super();
         _control = param1;
         init();
      }
      
      private function init() : void
      {
         _list = new Dictionary();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         createBogu();
         initEvent();
      }
      
      public function boguWalk(param1:Array) : void
      {
         clearWarnAction();
         _bogu.playerWalk(param1);
         _control.isMove = true;
         _move = true;
      }
      
      public function placeGoods(param1:String, param2:int, param3:Point) : void
      {
         var _loc4_:* = null;
         var _loc5_:String = param2.toString();
         if(_list[_loc5_] != null)
         {
            return;
         }
         _loc4_ = UICreatShortcut.creatAndAdd("boguAdventure.mapView." + param1,this);
         _loc4_.x = param3.x;
         _loc4_.y = param3.y;
         if(_mineNum)
         {
            swapChildren(_mineNum,_loc4_);
         }
         changeShowLevel(getChildIndex(_bogu));
         _list[_loc5_] = _loc4_;
      }
      
      public function celarGoods(param1:int) : void
      {
         var _loc3_:String = param1.toString();
         if(_list[_loc3_] == null)
         {
            return;
         }
         var _loc2_:Bitmap = _list[_loc3_] as Bitmap;
         ObjectUtils.disposeObject(_loc2_);
         _loc2_ = null;
         return;
         §§push(delete _list[_loc3_]);
      }
      
      public function playExplodAciton() : void
      {
         if(_explodeAction)
         {
            return;
         }
         _explodeAction = UICreatShortcut.creatAndAdd("boguAdventure.view.explodeAction",this);
         _explodeAction.stop();
         _explodeAction.x = _bogu.x + _bogu.focusPos.x;
         _explodeAction.y = _bogu.y - 11;
         _bogu.sceneCharacterActionType = "boguweep";
         changeShowLevel(getChildIndex(_bogu));
         _explodeAction.play();
         _explodeAction.addEventListener("enterFrame",__onPlayExplodAcitonComplete);
         SoundManager.instance.play("069");
      }
      
      public function playAwardAction(param1:int) : void
      {
         if(_awardImgae)
         {
            return;
         }
         _awardImgae = new CellContentCreator();
         _awardImgae.info = ItemManager.Instance.getTemplateById(param1);
         _awardImgae.loadSync(onCreateAwardImageComplete);
      }
      
      public function playWarnAction(param1:int, param2:Point) : void
      {
         clearWarnAction();
         if(!_mineNum && param1 > 0)
         {
            _mineNum = UICreatShortcut.creatAndAdd("boguAdventure.view.mineNum",this);
            _mineNum.setFrame(param1);
            _mineNum.x = param2.x;
            _mineNum.y = param2.y;
            addChild(_mineNum);
         }
      }
      
      public function update() : void
      {
         if(_bogu)
         {
            _bogu.update();
         }
         if(_move)
         {
            changeShowLevel(getChildIndex(_bogu));
         }
      }
      
      public function resetBogu(param1:Point) : void
      {
         _move = false;
         _control.isMove = false;
         _bogu.dir = SceneCharacterDirection.RB;
         _bogu.x = param1.x;
         _bogu.y = param1.y;
         addChild(_bogu);
      }
      
      public function clearChangeView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _list;
         for(var _loc1_ in _list)
         {
            ObjectUtils.disposeObject(_list[_loc1_] as Bitmap);
            _list[_loc1_] = null;
            delete _list[_loc1_];
         }
         _list = new Dictionary();
      }
      
      private function __onPlayExplodAcitonComplete(param1:Event) : void
      {
         if(_explodeAction.currentFrame == _explodeAction.totalFrames)
         {
            clearExplodeAction();
            _bogu.sceneCharacterActionType = "bogustop";
            _control.playActionComplete({"type":"actionexplode"});
         }
      }
      
      private function clearExplodeAction() : void
      {
         if(_explodeAction)
         {
            _explodeAction.stop();
            _explodeAction.removeEventListener("enterFrame",__onPlayExplodAcitonComplete);
            ObjectUtils.disposeAllChildren(_explodeAction);
            ObjectUtils.disposeObject(_explodeAction);
            _explodeAction = null;
         }
      }
      
      private function onCreateAwardImageComplete() : void
      {
         if(_awardAction)
         {
            return;
         }
         _awardAction = UICreatShortcut.creatAndAdd("boguAdventure.view.awardAction",this);
         _awardAction.stop();
         var _loc1_:int = 15;
         _awardImgae.height = _loc1_;
         _awardImgae.width = _loc1_;
         _awardAction["mc"].addChild(_awardImgae);
         _awardAction.x = _bogu.x + _bogu.focusPos.x - 133;
         _awardAction.y = _bogu.y;
         _bogu.sceneCharacterActionType = "bogulaugh";
         _awardAction.play();
         _awardAction.addEventListener("enterFrame",__onPlayAwardAcitonComplete);
      }
      
      private function __onPlayAwardAcitonComplete(param1:Event) : void
      {
         if(_awardAction.currentFrame == _awardAction.totalFrames)
         {
            clearAwardAction();
            _bogu.sceneCharacterActionType = "bogustop";
            _control.playActionComplete({"type":"actionaward"});
         }
      }
      
      private function clearAwardAction() : void
      {
         if(_awardAction)
         {
            _awardAction.stop();
            _awardAction.removeEventListener("enterFrame",__onPlayAwardAcitonComplete);
            ObjectUtils.disposeObject(_awardImgae);
            _awardImgae = null;
            ObjectUtils.disposeAllChildren(_awardAction);
            ObjectUtils.disposeObject(_awardAction);
            _awardAction = null;
         }
      }
      
      public function clearWarnAction() : void
      {
         if(_mineNum)
         {
            ObjectUtils.disposeObject(_mineNum);
            _mineNum = null;
         }
      }
      
      public function boguState(param1:Boolean) : void
      {
         ObjectUtils.disposeObject(_boguDie);
         _boguDie = null;
         if(param1)
         {
            _bogu.visible = true;
         }
         else
         {
            _boguDie = UICreatShortcut.creatAndAdd("boguAdventure.view.die",this);
            if(_bogu.dir == SceneCharacterDirection.LB)
            {
               _boguDie.scaleX = -1;
            }
            else
            {
               _boguDie.scaleX = 1;
            }
            _boguDie.x = _bogu.x;
            _boguDie.y = _bogu.y;
            _bogu.visible = false;
         }
      }
      
      private function __onStopMove(param1:SceneCharacterEvent) : void
      {
         if(!param1.data)
         {
            _move = false;
            _bogu.sceneCharacterActionType = "bogustop";
            _control.walkComplete();
         }
         else
         {
            _bogu.sceneCharacterActionType = "boguwalk";
         }
      }
      
      private function createBogu() : void
      {
         _bogu = new BoguAdventurePlayer(createBoguComplete);
         _bogu.moveSpeed = 0.2;
         _bogu.mouseChildren = false;
         _bogu.mouseEnabled = false;
         addChild(_bogu);
      }
      
      private function createBoguComplete(param1:BoguAdventurePlayer, param2:Boolean, param3:int = 0) : void
      {
         if(param2)
         {
            _bogu.sceneCharacterActionType = "bogustop";
            _control.bogu = _bogu;
            return;
         }
         throw new Error("加载啵咕形象失败!检查下资源文件!");
      }
      
      private function changeShowLevel(param1:int) : void
      {
         var _loc2_:DisplayObject = getChildAt(param1);
         var _loc5_:int = 0;
         var _loc4_:* = _list;
         for each(var _loc3_ in _list)
         {
            swapShowLevel(getChildIndex(_loc2_),getChildIndex(_loc3_));
         }
      }
      
      private function swapShowLevel(param1:int, param2:int) : void
      {
         if(param1 == param2)
         {
            return;
         }
         var _loc3_:DisplayObject = getChildAt(param1);
         var _loc4_:DisplayObject = getChildAt(param2);
         if(Math.abs(_loc3_.x - _loc4_.x) < 150 && Math.abs(_loc3_.y - _loc4_.y) < 150)
         {
            if(_loc3_.y + _loc3_.height > _loc4_.y + _loc4_.height)
            {
               if(param1 < param2)
               {
                  this.swapChildrenAt(param1,param2);
               }
            }
            else if(param1 > param2)
            {
               this.swapChildrenAt(param1,param2);
            }
         }
      }
      
      private function initEvent() : void
      {
         _bogu.addEventListener("characterDirectionChange",__onStopMove);
      }
      
      private function removeEvent() : void
      {
         _bogu.removeEventListener("characterDirectionChange",__onStopMove);
      }
      
      public function dispose() : void
      {
         removeEvent();
         clearAwardAction();
         clearExplodeAction();
         removeChild(_bogu);
         clearChangeView();
         clearWarnAction();
         _list = null;
         _bogu.dispose();
         _bogu = null;
         _control = null;
         ObjectUtils.disposeObject(_boguDie);
         _boguDie = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
