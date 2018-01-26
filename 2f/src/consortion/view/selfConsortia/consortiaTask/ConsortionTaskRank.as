package consortion.view.selfConsortia.consortiaTask
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortion.event.ConsortionEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class ConsortionTaskRank extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      protected var _pageBack:Scale9CornerImage;
      
      protected var _rightBtn:BaseButton;
      
      protected var _leftBtn:BaseButton;
      
      protected var _pageNum:FilterFrameText;
      
      private var _itemList:Vector.<TaskRankItem>;
      
      private var _totalPage:Number = 1;
      
      private var _curPage:Number = 1;
      
      private var _itemLengthPerPage:Number = 12;
      
      private var _taskRankArr:Array;
      
      public function ConsortionTaskRank(){super();}
      
      protected function taskRankListHander(param1:ConsortionEvent = null) : void{}
      
      private function mouseClickHander(param1:MouseEvent) : void{}
      
      private function setPageArr() : void{}
      
      private function clearAllItemData() : void{}
      
      override public function dispose() : void{}
      
      private function _response(param1:FrameEvent) : void{}
   }
}

import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.core.Disposeable;
import com.pickgliss.ui.image.ScaleFrameImage;
import com.pickgliss.ui.text.FilterFrameText;
import ddt.utils.PositionUtils;
import flash.display.Bitmap;
import flash.display.Sprite;

class TaskRankItem extends Sprite implements Disposeable
{
    
   
   private var _itemBg:Bitmap;
   
   private var _nameTxt:FilterFrameText;
   
   private var _rankTxt:FilterFrameText;
   
   private var _percentTxt:FilterFrameText;
   
   private var _contributeTxt:FilterFrameText;
   
   private var _topThreeIcon:ScaleFrameImage;
   
   function TaskRankItem(param1:int, param2:String = "", param3:String = "", param4:String = "", param5:String = ""){super();}
   
   public function update(param1:String = "", param2:String = "", param3:String = "", param4:String = "") : void{}
   
   public function dispose() : void{}
}
