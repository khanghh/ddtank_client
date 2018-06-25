package tofflist.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.view.selfConsortia.Badge;
   import ddt.data.ConsortiaInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.common.LevelIcon;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextFormat;
   import team.TeamManager;
   import team.model.TeamRankInfo;
   import tofflist.TofflistEvent;
   import tofflist.TofflistModel;
   import tofflist.data.TofflistConsortiaData;
   import tofflist.data.TofflistConsortiaInfo;
   import tofflist.data.TofflistPlayerInfo;
   import vip.VipController;
   
   public class TofflistOrderItem extends Sprite implements Disposeable
   {
       
      
      private var _consortiaInfo:TofflistConsortiaInfo;
      
      private var _badge:Badge;
      
      private var _index:int;
      
      private var _info:TofflistPlayerInfo;
      
      private var _teamRankinfo:TeamRankInfo;
      
      private var _isSelect:Boolean;
      
      private var _bg:Image;
      
      private var _shine:Scale9CornerImage;
      
      private var _level:LevelIcon;
      
      private var _vipName:GradientText;
      
      private var _topThreeRink:ScaleFrameImage;
      
      private var _horseNameStrList:Array;
      
      private var _levelStar:Bitmap;
      
      private var _teamSegmentIcon:ScaleFrameImage;
      
      private var _resourceArr:Array;
      
      private var _styleLinkArr:Array;
      
      private var _attestBtn:ScaleFrameImage;
      
      private var hLines:Array;
      
      public function TofflistOrderItem()
      {
         super();
         init();
         addEvent();
      }
      
      public function get currentText() : String
      {
         return _resourceArr[2].dis["text"];
      }
      
      public function dispose() : void
      {
         var dis:* = null;
         var i:* = 0;
         var total:* = 0;
         removeEvent();
         if(hLines)
         {
            var _loc6_:int = 0;
            var _loc5_:* = hLines;
            for each(var bm in hLines)
            {
               ObjectUtils.disposeObject(bm);
            }
         }
         if(_resourceArr)
         {
            i = uint(0);
            total = uint(_resourceArr.length);
            i;
            while(i < total)
            {
               dis = _resourceArr[i].dis;
               ObjectUtils.disposeObject(dis);
               dis = null;
               _resourceArr[i] = null;
               i++;
            }
            _resourceArr = null;
         }
         if(_teamSegmentIcon)
         {
            ObjectUtils.disposeObject(_teamSegmentIcon);
         }
         _teamSegmentIcon = null;
         _styleLinkArr = null;
         _badge.dispose();
         _badge = null;
         _bg.dispose();
         _bg = null;
         ObjectUtils.disposeAllChildren(this);
         _shine = null;
         if(_topThreeRink)
         {
            _topThreeRink.dispose();
         }
         _topThreeRink = null;
         if(_levelStar)
         {
            _levelStar.bitmapData.dispose();
         }
         _levelStar = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function set index(i:int) : void
      {
         this._index = i;
         _bg.setFrame(_index % 2 + 1);
      }
      
      public function get MountsLevel() : String
      {
         return _info.MountsLevelInfo;
      }
      
      public function showHLine(points:Vector.<Point>) : void
      {
         if(hLines)
         {
            var _loc5_:int = 0;
            var _loc4_:* = hLines;
            for each(var bm in hLines)
            {
               ObjectUtils.disposeObject(bm);
            }
         }
         hLines = [];
         var _loc7_:int = 0;
         var _loc6_:* = points;
         for each(var p in points)
         {
            bm = ComponentFactory.Instance.creatBitmap("asset.corel.formLine");
            addChild(bm);
            hLines.push(bm);
            PositionUtils.setPos(bm,new Point(p.x - parent.parent.x,p.y));
         }
      }
      
      public function get info() : Object
      {
         return this._info;
      }
      
      public function set info($info:Object) : void
      {
         var $consortiaInfo:* = null;
         if($info is PlayerInfo)
         {
            _info = $info as TofflistPlayerInfo;
         }
         else if($info is TofflistConsortiaData)
         {
            $consortiaInfo = $info as TofflistConsortiaData;
            if($consortiaInfo)
            {
               _info = $consortiaInfo.playerInfo;
               _consortiaInfo = $consortiaInfo.consortiaInfo;
            }
         }
         else if($info is TeamRankInfo)
         {
            _teamRankinfo = $info as TeamRankInfo;
         }
         if(_info)
         {
            upView();
         }
         if(_teamRankinfo)
         {
            upView();
         }
      }
      
      public function set isSelect(b:Boolean) : void
      {
         var _loc2_:* = b;
         this._isSelect = _loc2_;
         _shine.visible = _loc2_;
         if(b)
         {
            this.dispatchEvent(new TofflistEvent("tofflistitemselect",this));
         }
      }
      
      public function set resourceLink(value:String) : void
      {
         var dis:* = null;
         var obj:* = null;
         _resourceArr = [];
         var tempArr:Array = value.replace(/(\s*)|(\s*$)/g,"").split("|");
         var i:uint = 0;
         var total:uint = tempArr.length;
         i;
         while(i < total)
         {
            obj = {};
            obj.id = tempArr[i].split("#")[0];
            obj.className = tempArr[i].split("#")[1];
            dis = ComponentFactory.Instance.creat(obj.className);
            addChild(dis);
            obj.dis = dis;
            _resourceArr.push(obj);
            i++;
         }
      }
      
      public function set setAllStyleXY(value:String) : void
      {
         _styleLinkArr = value.replace(/(\s*)|(\s*$)/g,"").split("~");
         updateStyleXY();
      }
      
      public function updateStyleXY($id:int = 0) : void
      {
         var dis:* = null;
         var i:* = 0;
         var j:* = 0;
         var id:int = 0;
         var pot:* = null;
         var total:uint = _resourceArr.length;
         var tempArr:Array = _styleLinkArr[$id].split("|");
         total = tempArr.length;
         for(i = uint(0); i < total; )
         {
            dis = null;
            id = tempArr[i].split("#")[0];
            for(j = uint(0); j < _resourceArr.length; )
            {
               if(id == _resourceArr[j].id)
               {
                  dis = _resourceArr[j].dis;
                  break;
               }
               j++;
            }
            if(dis)
            {
               pot = new Point();
               pot.x = tempArr[i].split("#")[1].split(",")[0];
               pot.y = tempArr[i].split("#")[1].split(",")[1];
               dis.x = pot.x;
               dis.y = pot.y;
               if(tempArr[i].split("#")[1].split(",")[2])
               {
                  dis.width = tempArr[i].split("#")[1].split(",")[2];
               }
               if(tempArr[i].split("#")[1].split(",")[3])
               {
                  dis.height = tempArr[i].split("#")[1].split(",")[3];
               }
               dis["text"] = dis["text"];
               dis.visible = true;
            }
            i++;
         }
         if(_index < 4)
         {
            _topThreeRink.x = _resourceArr[0].dis.x - 9;
            _topThreeRink.y = _resourceArr[0].dis.y - 2;
            _topThreeRink.visible = true;
            _topThreeRink.setFrame(_index);
            _resourceArr[0].dis.visible = false;
         }
      }
      
      private function get NO_ID() : String
      {
         var str:String = "";
         switch(int(_index) - 1)
         {
            case 0:
               str = "1st";
               break;
            case 1:
               str = "2nd";
               break;
            case 2:
               str = "3rd";
         }
         return str;
      }
      
      private function __itemClickHandler(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!_isSelect)
         {
            isSelect = true;
         }
      }
      
      private function __itemMouseOutHandler(evt:MouseEvent) : void
      {
         if(_isSelect)
         {
            return;
         }
         _shine.visible = false;
      }
      
      private function __itemMouseOverHandler(evt:MouseEvent) : void
      {
         _shine.visible = true;
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__itemClickHandler);
         addEventListener("mouseOver",__itemMouseOverHandler);
         addEventListener("mouseOut",__itemMouseOutHandler);
         PlayerManager.Instance.Self.addEventListener("propertychange",__offerChange);
      }
      
      private function __offerChange(evt:PlayerPropertyEvent) : void
      {
         if(evt.changedProperties["isVip"])
         {
            upView();
         }
      }
      
      private function init() : void
      {
         _horseNameStrList = LanguageMgr.GetTranslation("horse.horseNameStr").split(",");
         this.graphics.beginFill(0,0);
         this.graphics.drawRect(0,0,495,30);
         this.graphics.endFill();
         this.buttonMode = true;
         _bg = ComponentFactory.Instance.creatComponentByStylename("tofflist.gridItemBg");
         _bg.setFrame(_index % 2 + 1);
         addChild(_bg);
         _shine = ComponentFactory.Instance.creat("tofflist.orderlistitem.shine");
         _shine.visible = false;
         addChild(_shine);
         _badge = new Badge();
         _badge.visible = false;
         addChild(_badge);
         PositionUtils.setPos(_badge,"tofflist.item.badgePos");
         _level = new LevelIcon();
         _level.setSize(1);
         addChild(_level);
         _level.visible = false;
         _topThreeRink = ComponentFactory.Instance.creat("toffilist.topThreeRink");
         addChild(_topThreeRink);
         _topThreeRink.visible = false;
         _teamSegmentIcon = ComponentFactory.Instance.creat("ddtcorei.playerinfoView.teamIcon");
         _teamSegmentIcon.tipStyle = "";
         _teamSegmentIcon.x = 263;
         _teamSegmentIcon.y = -2;
         var _loc1_:* = 0.9;
         _teamSegmentIcon.scaleY = _loc1_;
         _teamSegmentIcon.scaleX = _loc1_;
         addChild(_teamSegmentIcon);
         _teamSegmentIcon.visible = false;
         _levelStar = ComponentFactory.Instance.creat("asset.Toffilist.levelStarTxtImage");
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__itemClickHandler);
         removeEventListener("mouseOver",__itemMouseOverHandler);
         removeEventListener("mouseOut",__itemMouseOutHandler);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__offerChange);
      }
      
      private function upView() : void
      {
         var dis:* = null;
         var i:* = 0;
         var textFormat:* = null;
         var textFormat1:* = null;
         var total:uint = _resourceArr.length;
         for(i = uint(0); i < total; )
         {
            dis = _resourceArr[i].dis;
            dis["text"] = "";
            dis.visible = false;
            i++;
         }
         _resourceArr[0].dis["text"] = NO_ID;
         _levelStar.visible = false;
         _teamSegmentIcon.visible = false;
         var _loc6_:* = TofflistModel.firstMenuType;
         if("personal" !== _loc6_)
         {
            if("crossServerPersonal" !== _loc6_)
            {
               if("consortia" !== _loc6_)
               {
                  if("crossServerConsortia" !== _loc6_)
                  {
                     if("teams" !== _loc6_)
                     {
                        if("crossServerTeams" === _loc6_)
                        {
                           updateStyleXY(20);
                           _resourceArr[1].dis["text"] = _teamRankinfo.TeamName;
                           _resourceArr[2].dis["text"] = _teamRankinfo.AreaName;
                           _resourceArr[3].dis["text"] = _teamRankinfo.TeamScore;
                           _teamSegmentIcon.visible = true;
                           _teamSegmentIcon.x = 210;
                           _teamSegmentIcon.y = -3;
                           _teamSegmentIcon.setFrame(TeamManager.instance.model.getTeamBattleSegment(_teamRankinfo.TeamScore) + 2);
                        }
                     }
                     else
                     {
                        updateStyleXY(19);
                        _resourceArr[1].dis["text"] = _teamRankinfo.TeamName;
                        _resourceArr[2].dis["text"] = _teamRankinfo.TeamScore;
                        _teamSegmentIcon.visible = true;
                        _teamSegmentIcon.x = 263;
                        _teamSegmentIcon.y = -2;
                        _teamSegmentIcon.setFrame(TeamManager.instance.model.getTeamBattleSegment(_teamRankinfo.TeamScore) + 2);
                     }
                  }
                  else if(_consortiaInfo)
                  {
                     _badge.visible = _consortiaInfo.BadgeID > 0;
                     _badge.badgeID = _consortiaInfo.BadgeID;
                     _resourceArr[1].dis["text"] = _consortiaInfo.ConsortiaName;
                     if(_consortiaInfo.AreaName)
                     {
                        _resourceArr[3].dis["text"] = _consortiaInfo.AreaName;
                     }
                     _loc6_ = TofflistModel.secondMenuType;
                     if("battle" !== _loc6_)
                     {
                        if("level" !== _loc6_)
                        {
                           if("assets" !== _loc6_)
                           {
                              if("charm" === _loc6_)
                              {
                                 updateStyleXY(16);
                                 _loc6_ = TofflistModel.thirdMenuType;
                                 if("day" !== _loc6_)
                                 {
                                    if("week" !== _loc6_)
                                    {
                                       if("total" === _loc6_)
                                       {
                                          _resourceArr[2].dis["text"] = _consortiaInfo.ConsortiaGiftGp;
                                       }
                                    }
                                    else
                                    {
                                       _resourceArr[2].dis["text"] = _consortiaInfo.ConsortiaAddWeekGiftGp;
                                    }
                                 }
                                 else
                                 {
                                    _resourceArr[2].dis["text"] = _consortiaInfo.ConsortiaAddDayGiftGp;
                                 }
                              }
                           }
                           else
                           {
                              updateStyleXY(15);
                              _loc6_ = TofflistModel.thirdMenuType;
                              if("day" !== _loc6_)
                              {
                                 if("week" !== _loc6_)
                                 {
                                    if("total" === _loc6_)
                                    {
                                       _resourceArr[2].dis["text"] = _consortiaInfo.LastDayRiches;
                                    }
                                 }
                                 else
                                 {
                                    _resourceArr[2].dis["text"] = _consortiaInfo.AddWeekRiches;
                                 }
                              }
                              else
                              {
                                 _resourceArr[2].dis["text"] = _consortiaInfo.AddDayRiches;
                              }
                           }
                        }
                        else
                        {
                           updateStyleXY(14);
                           _loc6_ = TofflistModel.thirdMenuType;
                           if("total" === _loc6_)
                           {
                              _resourceArr[2].dis["text"] = _consortiaInfo.LastDayRiches;
                              _resourceArr[4].dis["text"] = _consortiaInfo.Level;
                           }
                        }
                     }
                     else
                     {
                        updateStyleXY(13);
                        _loc6_ = TofflistModel.thirdMenuType;
                        if("total" === _loc6_)
                        {
                           if(_consortiaInfo.FightPower < 0)
                           {
                              _resourceArr[2].dis["text"] = _consortiaInfo.FightPower + Math.pow(2,32);
                           }
                           else
                           {
                              _resourceArr[2].dis["text"] = _consortiaInfo.FightPower;
                           }
                        }
                     }
                  }
               }
               else if(_consortiaInfo)
               {
                  _badge.visible = _consortiaInfo.BadgeID > 0;
                  _badge.badgeID = _consortiaInfo.BadgeID;
                  _resourceArr[1].dis["text"] = _consortiaInfo.ConsortiaName;
                  _loc6_ = TofflistModel.secondMenuType;
                  if("battle" !== _loc6_)
                  {
                     if("level" !== _loc6_)
                     {
                        if("assets" !== _loc6_)
                        {
                           if("charm" === _loc6_)
                           {
                              updateStyleXY(8);
                              _loc6_ = TofflistModel.thirdMenuType;
                              if("day" !== _loc6_)
                              {
                                 if("week" !== _loc6_)
                                 {
                                    if("total" === _loc6_)
                                    {
                                       _resourceArr[2].dis["text"] = _consortiaInfo.ConsortiaGiftGp;
                                    }
                                 }
                                 else
                                 {
                                    _resourceArr[2].dis["text"] = _consortiaInfo.ConsortiaAddWeekGiftGp;
                                 }
                              }
                              else
                              {
                                 _resourceArr[2].dis["text"] = _consortiaInfo.ConsortiaAddDayGiftGp;
                              }
                           }
                        }
                        else
                        {
                           updateStyleXY(7);
                           _loc6_ = TofflistModel.thirdMenuType;
                           if("day" !== _loc6_)
                           {
                              if("week" !== _loc6_)
                              {
                                 if("total" === _loc6_)
                                 {
                                    _resourceArr[2].dis["text"] = _consortiaInfo.LastDayRiches;
                                 }
                              }
                              else
                              {
                                 _resourceArr[2].dis["text"] = _consortiaInfo.AddWeekRiches;
                              }
                           }
                           else
                           {
                              _resourceArr[2].dis["text"] = _consortiaInfo.AddDayRiches;
                           }
                        }
                     }
                     else
                     {
                        updateStyleXY(6);
                        _loc6_ = TofflistModel.thirdMenuType;
                        if("total" === _loc6_)
                        {
                           _resourceArr[2].dis["text"] = _consortiaInfo.LastDayRiches;
                           _resourceArr[3].dis["text"] = _consortiaInfo.Level;
                        }
                     }
                  }
                  else
                  {
                     updateStyleXY(5);
                     _loc6_ = TofflistModel.thirdMenuType;
                     if("total" === _loc6_)
                     {
                        if(_consortiaInfo.FightPower < 0)
                        {
                           _resourceArr[2].dis["text"] = _consortiaInfo.FightPower + Math.pow(2,32);
                        }
                        else
                        {
                           _resourceArr[2].dis["text"] = _consortiaInfo.FightPower;
                        }
                     }
                  }
               }
            }
            else
            {
               _resourceArr[1].dis["text"] = _info.NickName;
               _resourceArr[3].dis["text"] = !!_info.AreaName?_info.AreaName:"";
               _loc6_ = TofflistModel.secondMenuType;
               if("battle" !== _loc6_)
               {
                  if("level" !== _loc6_)
                  {
                     if("achievementpoint" !== _loc6_)
                     {
                        if("charm" !== _loc6_)
                        {
                           if("mounts" === _loc6_)
                           {
                              updateStyleXY(18);
                              _levelStar.visible = true;
                              PositionUtils.setPos(_levelStar,"tofflist.cross.levelStarPos");
                              _resourceArr[2].dis["text"] = _horseNameStrList[_info.MountsLevel];
                              _resourceArr[5].dis["text"] = _info.MountsLevelInfo;
                           }
                        }
                        else
                        {
                           updateStyleXY(12);
                           _loc6_ = TofflistModel.thirdMenuType;
                           if("day" !== _loc6_)
                           {
                              if("week" !== _loc6_)
                              {
                                 if("total" === _loc6_)
                                 {
                                    _resourceArr[2].dis["text"] = _info.GiftGp;
                                    _resourceArr[4].dis["text"] = _info.GiftLevel;
                                 }
                              }
                              else
                              {
                                 _resourceArr[2].dis["text"] = _info.AddWeekGiftGp;
                                 _resourceArr[4].dis["text"] = _info.GiftLevel;
                              }
                           }
                           else
                           {
                              _resourceArr[2].dis["text"] = _info.AddDayGiftGp;
                              _resourceArr[4].dis["text"] = _info.GiftLevel;
                           }
                        }
                     }
                     else
                     {
                        updateStyleXY(11);
                        _loc6_ = TofflistModel.thirdMenuType;
                        if("day" !== _loc6_)
                        {
                           if("week" !== _loc6_)
                           {
                              if("total" === _loc6_)
                              {
                                 _resourceArr[2].dis["text"] = _info.AchievementPoint;
                              }
                           }
                           else
                           {
                              _resourceArr[2].dis["text"] = _info.AddWeekAchievementPoint;
                           }
                        }
                        else
                        {
                           _resourceArr[2].dis["text"] = _info.AddDayAchievementPoint;
                        }
                     }
                  }
                  else
                  {
                     updateStyleXY(10);
                     if(_vipName)
                     {
                        _vipName.x = _resourceArr[1].dis.x - _vipName.width / 2;
                     }
                     _level.x = 208;
                     _level.y = 3;
                     _level.setInfo(_info.Grade,_info.ddtKingGrade,_info.Repute,_info.WinCount,_info.TotalCount,_info.FightPower,_info.Offer,true,false);
                     _level.visible = true;
                     _loc6_ = TofflistModel.thirdMenuType;
                     if("day" !== _loc6_)
                     {
                        if("week" !== _loc6_)
                        {
                           if("total" === _loc6_)
                           {
                              _resourceArr[2].dis["text"] = _info.GP;
                           }
                        }
                        else
                        {
                           _resourceArr[2].dis["text"] = _info.AddWeekGP;
                        }
                     }
                     else
                     {
                        _resourceArr[2].dis["text"] = _info.AddDayGP;
                     }
                  }
               }
               else
               {
                  updateStyleXY(9);
                  _loc6_ = TofflistModel.thirdMenuType;
                  if("total" === _loc6_)
                  {
                     _resourceArr[2].dis["text"] = _info.FightPower;
                  }
               }
               if(_info.IsVIP)
               {
                  if(_vipName)
                  {
                     ObjectUtils.disposeObject(_vipName);
                  }
                  _vipName = VipController.instance.getVipNameTxt(1,_info.typeVIP);
                  textFormat1 = new TextFormat();
                  textFormat1.align = "center";
                  textFormat1.bold = true;
                  _vipName.textField.defaultTextFormat = textFormat1;
                  _vipName.textSize = 16;
                  _vipName.textField.width = _resourceArr[1].dis.width;
                  _vipName.x = _resourceArr[1].dis.x;
                  _vipName.y = _resourceArr[1].dis.y;
                  _vipName.text = _info.NickName;
                  addChild(_vipName);
               }
               PositionUtils.adaptNameStyle(_info,_resourceArr[1].dis,_vipName);
               creatAttestBtn();
            }
         }
         else
         {
            _resourceArr[1].dis["text"] = _info.NickName;
            _loc6_ = TofflistModel.secondMenuType;
            if("battle" !== _loc6_)
            {
               if("level" !== _loc6_)
               {
                  if("achievementpoint" !== _loc6_)
                  {
                     if("charm" !== _loc6_)
                     {
                        if("matches" !== _loc6_)
                        {
                           if("mounts" === _loc6_)
                           {
                              updateStyleXY(17);
                              _levelStar.visible = true;
                              PositionUtils.setPos(_levelStar,"tofflist.person.levelStarPos");
                              _resourceArr[3].dis["text"] = _horseNameStrList[_info.MountsLevel];
                              _resourceArr[5].dis["text"] = String(_info.MountsLevelInfo);
                           }
                        }
                        else
                        {
                           updateStyleXY(4);
                           _loc6_ = TofflistModel.thirdMenuType;
                           if("day" !== _loc6_)
                           {
                              if("week" !== _loc6_)
                              {
                                 if("total" === _loc6_)
                                 {
                                    _resourceArr[2].dis["text"] = String(_info.TotalPrestige);
                                 }
                              }
                              else
                              {
                                 _resourceArr[2].dis["text"] = String(_info.AddWeekPrestige);
                              }
                           }
                           else
                           {
                              _resourceArr[2].dis["text"] = String(_info.AddDayPrestige);
                           }
                        }
                     }
                     else
                     {
                        updateStyleXY(3);
                        _loc6_ = TofflistModel.thirdMenuType;
                        if("day" !== _loc6_)
                        {
                           if("week" !== _loc6_)
                           {
                              if("total" === _loc6_)
                              {
                                 _resourceArr[2].dis["text"] = _info.GiftGp;
                                 _resourceArr[3].dis["text"] = _info.GiftLevel;
                              }
                           }
                           else
                           {
                              _resourceArr[2].dis["text"] = _info.AddWeekGiftGp;
                              _resourceArr[3].dis["text"] = _info.GiftLevel;
                           }
                        }
                        else
                        {
                           _resourceArr[2].dis["text"] = _info.AddDayGiftGp;
                           _resourceArr[3].dis["text"] = _info.GiftLevel;
                        }
                     }
                  }
                  else
                  {
                     updateStyleXY(2);
                     _loc6_ = TofflistModel.thirdMenuType;
                     if("day" !== _loc6_)
                     {
                        if("week" !== _loc6_)
                        {
                           if("total" === _loc6_)
                           {
                              _resourceArr[2].dis["text"] = _info.AchievementPoint;
                           }
                        }
                        else
                        {
                           _resourceArr[2].dis["text"] = _info.AddWeekAchievementPoint;
                        }
                     }
                     else
                     {
                        _resourceArr[2].dis["text"] = _info.AddDayAchievementPoint;
                     }
                  }
               }
               else
               {
                  updateStyleXY(1);
                  if(_vipName)
                  {
                     _vipName.x = _resourceArr[1].dis.x - _vipName.width / 2;
                  }
                  _level.x = 227;
                  _level.y = 3;
                  _level.setInfo(_info.Grade,_info.ddtKingGrade,_info.Repute,_info.WinCount,_info.TotalCount,_info.FightPower,_info.Offer,true,false);
                  _level.visible = true;
                  _loc6_ = TofflistModel.thirdMenuType;
                  if("day" !== _loc6_)
                  {
                     if("week" !== _loc6_)
                     {
                        if("total" === _loc6_)
                        {
                           _resourceArr[2].dis["text"] = _info.GP;
                        }
                     }
                     else
                     {
                        _resourceArr[2].dis["text"] = _info.AddWeekGP;
                     }
                  }
                  else
                  {
                     _resourceArr[2].dis["text"] = _info.AddDayGP;
                  }
               }
            }
            else
            {
               updateStyleXY(0);
               _loc6_ = TofflistModel.thirdMenuType;
               if("total" === _loc6_)
               {
                  _resourceArr[2].dis["text"] = _info.FightPower;
               }
            }
            if(_info.IsVIP)
            {
               if(_vipName)
               {
                  ObjectUtils.disposeObject(_vipName);
               }
               _vipName = VipController.instance.getVipNameTxt(1,_info.typeVIP);
               textFormat = new TextFormat();
               textFormat.align = "center";
               textFormat.bold = true;
               _vipName.textField.defaultTextFormat = textFormat;
               _vipName.textSize = 16;
               _vipName.textField.width = _resourceArr[1].dis.width;
               _vipName.x = _resourceArr[1].dis.x;
               _vipName.y = _resourceArr[1].dis.y;
               _vipName.text = _info.NickName;
            }
            PositionUtils.adaptNameStyle(_info,_resourceArr[1].dis,_vipName);
            creatAttestBtn();
         }
         if(_vipName)
         {
            addChild(_vipName);
         }
      }
      
      private function creatAttestBtn() : void
      {
         if(_info.isAttest)
         {
            _attestBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.attest");
            _attestBtn.buttonMode = true;
            addChild(_attestBtn);
            if(_info.IsVIP)
            {
               _attestBtn.x = _vipName.x + _vipName.width;
               _attestBtn.y = _vipName.y;
            }
            else
            {
               _attestBtn.x = _resourceArr[1].dis.x + _resourceArr[1].dis.width;
               _attestBtn.y = _resourceArr[1].dis.y;
            }
         }
      }
      
      public function get consortiaInfo() : ConsortiaInfo
      {
         return _consortiaInfo;
      }
      
      public function get teamRankinfo() : TeamRankInfo
      {
         return _teamRankinfo;
      }
   }
}
