package ddt.view.chat
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class ChatFacePanel extends ChatBasePanel
   {
      
      public static const FIGHT_FACE_ID_START:int = 49;
      
      public static const FIGHT_FACE_ID_END:int = 74;
      
      private static const MAX_FACE_CNT:uint = 72;
      
      private static const COLUMN_LENGTH:uint = 10;
      
      private static const FACE_SPAN:uint = 25;
       
      
      protected var _bg:ScaleBitmapImage;
      
      private var _faceBtns:Vector.<BaseButton>;
      
      private var _inGame:Boolean;
      
      private var _selected:int;
      
      public function ChatFacePanel(inGame:Boolean = false)
      {
         _faceBtns = new Vector.<BaseButton>();
         super();
         _inGame = inGame;
      }
      
      public function dispose() : void
      {
         removeChild(_bg);
         var _loc3_:int = 0;
         var _loc2_:* = _faceBtns;
         for each(var btn in _faceBtns)
         {
            btn.dispose();
         }
         _faceBtns = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get selected() : int
      {
         return _selected;
      }
      
      private function __itemClick(evt:MouseEvent) : void
      {
         var str:String = (evt.target as BaseButton).backStyle;
         SoundManager.instance.play("008");
         var id:int = str.slice(str.length - 2);
         if(id >= 49 && id <= 71)
         {
            id = id + 30;
         }
         _selected = id;
         dispatchEvent(new Event("select"));
      }
      
      protected function createBg() : void
      {
         _bg = ComponentFactory.Instance.creat("chat.FacePanelBg");
         _bg.y = -77;
         addChild(_bg);
      }
      
      override protected function init() : void
      {
         var i:int = 0;
         var bt:* = null;
         super.init();
         createBg();
         var _facePos:Point = ComponentFactory.Instance.creatCustomObject("chat.FacePanelFacePos");
         var rowIdx:uint = 0;
         var colIdx:uint = 0;
         var disabledList:Array = PathManager.solveChatFaceDisabledList();
         for(i = 1; i < 72; i++)
         {
            if(!(disabledList && disabledList.indexOf(String(i)) > -1))
            {
               if(colIdx == 10)
               {
                  colIdx = 0;
                  rowIdx++;
               }
               bt = new BaseButton();
               bt.beginChanges();
               bt.backStyle = "asset.chat.FaceBtn_" + (i < 10?"0" + String(i):String(i));
               bt.tipStyle = "core.ChatFaceTips";
               bt.tipDirctions = "4";
               bt.tipGapV = 5;
               bt.tipGapH = -5;
               bt.tipData = LanguageMgr.GetTranslation("tank.view.chat.ChatFacePannel.face" + String(i));
               bt.commitChanges();
               bt.x = colIdx * 25 + _facePos.x;
               bt.y = rowIdx * 25 + _facePos.y;
               bt.addEventListener("click",__itemClick);
               _faceBtns.push(bt);
               addChild(bt);
               colIdx++;
            }
         }
      }
   }
}
