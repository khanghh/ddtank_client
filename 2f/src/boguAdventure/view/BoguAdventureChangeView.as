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
      
      public function BoguAdventureChangeView(param1:BoguAdventureControl){super();}
      
      private function init() : void{}
      
      public function boguWalk(param1:Array) : void{}
      
      public function placeGoods(param1:String, param2:int, param3:Point) : void{}
      
      public function celarGoods(param1:int) : void{}
      
      public function playExplodAciton() : void{}
      
      public function playAwardAction(param1:int) : void{}
      
      public function playWarnAction(param1:int, param2:Point) : void{}
      
      public function update() : void{}
      
      public function resetBogu(param1:Point) : void{}
      
      public function clearChangeView() : void{}
      
      private function __onPlayExplodAcitonComplete(param1:Event) : void{}
      
      private function clearExplodeAction() : void{}
      
      private function onCreateAwardImageComplete() : void{}
      
      private function __onPlayAwardAcitonComplete(param1:Event) : void{}
      
      private function clearAwardAction() : void{}
      
      public function clearWarnAction() : void{}
      
      public function boguState(param1:Boolean) : void{}
      
      private function __onStopMove(param1:SceneCharacterEvent) : void{}
      
      private function createBogu() : void{}
      
      private function createBoguComplete(param1:BoguAdventurePlayer, param2:Boolean, param3:int = 0) : void{}
      
      private function changeShowLevel(param1:int) : void{}
      
      private function swapShowLevel(param1:int, param2:int) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
