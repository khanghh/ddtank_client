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
      
      public function ConsortionTaskRank()
      {
         var i:int = 0;
         var item:* = null;
         super();
         titleText = LanguageMgr.GetTranslation("consortia.taskRank.title");
         _bg = ComponentFactory.Instance.creatBitmap("asset.consortion.taskRankBG");
         addToContent(_bg);
         _pageBack = ComponentFactory.Instance.creatComponentByStylename("asset.consortion.upDownTextBgImgAsset");
         PositionUtils.setPos(_pageBack,"taskRank.bg.pos");
         addToContent(_pageBack);
         _rightBtn = ComponentFactory.Instance.creatComponentByStylename("consortion.rank.nextPageBtn");
         PositionUtils.setPos(_rightBtn,"taskRank.right.pos");
         addToContent(_rightBtn);
         _leftBtn = ComponentFactory.Instance.creatComponentByStylename("consortion.rank.prePageBtn");
         PositionUtils.setPos(_leftBtn,"taskRank.left.pos");
         addToContent(_leftBtn);
         _pageNum = ComponentFactory.Instance.creatComponentByStylename("consortion.rank.pageNum");
         PositionUtils.setPos(_pageNum,"taskRank.num.pos");
         _pageNum.autoSize = "center";
         _pageNum.text = "1/1";
         addToContent(_pageNum);
         _itemList = new Vector.<TaskRankItem>();
         for(i = 0; i < _itemLengthPerPage; )
         {
            item = new TaskRankItem(i,"","","","");
            item.x = 30;
            item.y = (item.height + 1) * i + 92;
            addToContent(item);
            _itemList.push(item);
            i++;
         }
         _rightBtn.addEventListener("click",mouseClickHander);
         _leftBtn.addEventListener("click",mouseClickHander);
         addEventListener("response",_response);
         ConsortionModelManager.Instance.addEventListener("task_rank_list",taskRankListHander);
         ConsortionModelManager.Instance.getConsortionTaskRank();
      }
      
      protected function taskRankListHander(e:ConsortionEvent = null) : void
      {
         if(e != null)
         {
            _taskRankArr = e.data as Array;
         }
         _totalPage = Math.max(Math.ceil(_taskRankArr.length / _itemLengthPerPage),1);
         _pageNum.text = "1/" + _totalPage.toString();
         setPageArr();
      }
      
      private function mouseClickHander(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(!_taskRankArr)
         {
            return;
         }
         var _loc2_:* = e.currentTarget;
         if(_rightBtn !== _loc2_)
         {
            if(_leftBtn === _loc2_)
            {
               _curPage = Number(_curPage) - 1;
               if(_curPage < 1)
               {
                  _curPage = _totalPage;
               }
            }
         }
         else
         {
            _curPage = Number(_curPage) + 1;
            if(_curPage > _totalPage)
            {
               _curPage = 1;
            }
         }
         _pageNum.text = _curPage + "/" + _totalPage;
         setPageArr();
      }
      
      private function setPageArr() : void
      {
         var arr:* = null;
         var i:int = 0;
         var startIndex:int = (_curPage - 1) * _itemLengthPerPage;
         var endIndex:int = Math.min(_curPage * _itemLengthPerPage,_taskRankArr.length);
         arr = _taskRankArr.slice(startIndex,endIndex);
         clearAllItemData();
         var len:int = arr.length;
         for(i = 0; i < len; )
         {
            _itemList[i].update(arr[i].name,arr[i].rank,String(arr[i].percent) + "%",arr[i].contribute);
            i++;
         }
      }
      
      private function clearAllItemData() : void
      {
         var i:int = 0;
         var len:int = _itemList.length;
         for(i = 0; i < len; )
         {
            _itemList[i].update();
            i++;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _rightBtn.removeEventListener("click",mouseClickHander);
         _leftBtn.removeEventListener("click",mouseClickHander);
         removeEventListener("response",_response);
         ConsortionModelManager.Instance.removeEventListener("task_rank_list",taskRankListHander);
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _pageBack = null;
         _itemList.length = 0;
         _itemList = null;
         _rightBtn = null;
         _leftBtn = null;
         _pageNum = null;
         _taskRankArr && _loc1_;
         _taskRankArr = null;
      }
      
      private function _response(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            ObjectUtils.disposeObject(this);
         }
      }
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
   
   function TaskRankItem(index:int, $name:String = "", $rank:String = "", $percent:String = "", $contribute:String = "")
   {
      super();
      if(int(index) % 2 == 0)
      {
         _itemBg = ComponentFactory.Instance.creat("asset.consortion.taskRankItem.bg1");
      }
      else
      {
         _itemBg = ComponentFactory.Instance.creat("asset.consortion.taskRankItem.bg2");
      }
      addChild(_itemBg);
      _topThreeIcon = ComponentFactory.Instance.creat("consortion.rankThreeRink");
      PositionUtils.setPos(_topThreeIcon,"taskRank.rankTop3.pos");
      addChild(_topThreeIcon);
      _topThreeIcon.visible = false;
      _nameTxt = ComponentFactory.Instance.creat("consortion.taskRank.nameTxt");
      _nameTxt.autoSize = "center";
      _rankTxt = ComponentFactory.Instance.creat("consortion.taskRank.rankTxt");
      _rankTxt.autoSize = "center";
      _percentTxt = ComponentFactory.Instance.creat("consortion.taskRank.percentTxt");
      _percentTxt.autoSize = "center";
      _contributeTxt = ComponentFactory.Instance.creat("consortion.taskRank.contributeTxt");
      _contributeTxt.autoSize = "center";
      addChild(_nameTxt);
      addChild(_rankTxt);
      addChild(_percentTxt);
      addChild(_contributeTxt);
      _nameTxt.text = $name;
      _rankTxt.text = $rank;
      _percentTxt.text = $percent;
      _contributeTxt.text = $contribute;
   }
   
   public function update($name:String = "", $rank:String = "", $percent:String = "", $contribute:String = "") : void
   {
      _nameTxt.text = $name;
      if(int($rank) < 4 && $rank != "")
      {
         _topThreeIcon.setFrame(int($rank));
         _topThreeIcon.visible = true;
         _rankTxt.visible = false;
      }
      else
      {
         _rankTxt.text = $rank;
         _rankTxt.visible = true;
         _topThreeIcon.visible = false;
      }
      _percentTxt.text = $percent;
      _contributeTxt.text = $contribute;
   }
   
   public function dispose() : void
   {
   }
}
