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
      
      public function BoguAdventureChangeView(control:BoguAdventureControl)
      {
         super();
         _control = control;
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
      
      public function boguWalk(path:Array) : void
      {
         clearWarnAction();
         _bogu.playerWalk(path);
         _control.isMove = true;
         _move = true;
      }
      
      public function placeGoods(type:String, index:int, indexPos:Point) : void
      {
         var goods:* = null;
         var key:String = index.toString();
         if(_list[key] != null)
         {
            return;
         }
         goods = UICreatShortcut.creatAndAdd("boguAdventure.mapView." + type,this);
         goods.x = indexPos.x;
         goods.y = indexPos.y;
         if(_mineNum)
         {
            swapChildren(_mineNum,goods);
         }
         changeShowLevel(getChildIndex(_bogu));
         _list[key] = goods;
      }
      
      public function celarGoods(index:int) : void
      {
         var key:String = index.toString();
         if(_list[key] == null)
         {
            return;
         }
         var sign:Bitmap = _list[key] as Bitmap;
         ObjectUtils.disposeObject(sign);
         sign = null;
         return;
         §§push(delete _list[key]);
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
      
      public function playAwardAction(templateId:int) : void
      {
         if(_awardImgae)
         {
            return;
         }
         _awardImgae = new CellContentCreator();
         _awardImgae.info = ItemManager.Instance.getTemplateById(templateId);
         _awardImgae.loadSync(onCreateAwardImageComplete);
      }
      
      public function playWarnAction(value:int, pos:Point) : void
      {
         clearWarnAction();
         if(!_mineNum && value > 0)
         {
            _mineNum = UICreatShortcut.creatAndAdd("boguAdventure.view.mineNum",this);
            _mineNum.setFrame(value);
            _mineNum.x = pos.x;
            _mineNum.y = pos.y;
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
      
      public function resetBogu(pos:Point) : void
      {
         _move = false;
         _control.isMove = false;
         _bogu.dir = SceneCharacterDirection.RB;
         _bogu.x = pos.x;
         _bogu.y = pos.y;
         addChild(_bogu);
      }
      
      public function clearChangeView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _list;
         for(var key in _list)
         {
            ObjectUtils.disposeObject(_list[key] as Bitmap);
            _list[key] = null;
            delete _list[key];
         }
         _list = new Dictionary();
      }
      
      private function __onPlayExplodAcitonComplete(e:Event) : void
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
      
      private function __onPlayAwardAcitonComplete(e:Event) : void
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
      
      public function boguState(value:Boolean) : void
      {
         ObjectUtils.disposeObject(_boguDie);
         _boguDie = null;
         if(value)
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
      
      private function __onStopMove(e:SceneCharacterEvent) : void
      {
         if(!e.data)
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
      
      private function createBoguComplete(bogu:BoguAdventurePlayer, isLoadSucceed:Boolean, index:int = 0) : void
      {
         if(isLoadSucceed)
         {
            _bogu.sceneCharacterActionType = "bogustop";
            _control.bogu = _bogu;
            return;
         }
         throw new Error("加载啵咕形象失败!检查下资源文件!");
      }
      
      private function changeShowLevel(index:int) : void
      {
         var obj1:DisplayObject = getChildAt(index);
         var _loc5_:int = 0;
         var _loc4_:* = _list;
         for each(var obj2 in _list)
         {
            swapShowLevel(getChildIndex(obj1),getChildIndex(obj2));
         }
      }
      
      private function swapShowLevel(index1:int, index2:int) : void
      {
         if(index1 == index2)
         {
            return;
         }
         var obj1:DisplayObject = getChildAt(index1);
         var obj2:DisplayObject = getChildAt(index2);
         if(Math.abs(obj1.x - obj2.x) < 150 && Math.abs(obj1.y - obj2.y) < 150)
         {
            if(obj1.y + obj1.height > obj2.y + obj2.height)
            {
               if(index1 < index2)
               {
                  this.swapChildrenAt(index1,index2);
               }
            }
            else if(index1 > index2)
            {
               this.swapChildrenAt(index1,index2);
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
