//
//  Index.swift
//  
//
//  Created by 史 翔新 on 2022/12/16.
//

import Foundation
//import Ink

struct Index {
    
    let html: String
    
    init() {
        html = content
    }
    
}

// TODO: Find a new MarkDown parser
private let content = #"""
    <!DOCTYPE html>
    <html lang="ja">
    <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title>株式会社ゆめみ iOS 未経験者エンジニア向けコードチェック課題</title>
    </head>
    <body>
    <h1>株式会社ゆめみ iOS 未経験者エンジニア向けコードチェック課題</h1>

    <h2>概要</h2>
    <p>本エンドポイントは株式会社ゆめみ（以下弊社）が、弊社に iOS エンジニアを希望する未経験の方に出す課題のバックエンドです。未経験者の方は<a
            href="https://github.com/yumemi-inc/ios-engineer-codecheck">リファクタリングの課題</a>もしくは本課題のいずれかを提出してください。本課題をお選びの方は、下記を詳しく読んだ上で課題に取り組んでください。
    </p>

    <h2>アプリ仕様</h2>
    <p>「あなたと相性のいい都道府県を占ってあげる！」をテーマに iPhone アプリを作ってください。API 仕様下記の通りです。</p>

    <h3>API 仕様</h3>
    <ul>
        <li>Base URL:</li>
        <p>"https://yumemi-ios-junior-engineer-codecheck.app.swift.cloud"</p>

        <li>End Point:</li>
        <p>"/my_fortune"</p>

        <li>HTTP Method:</li>
        <p>"POST"</p>

        <li>HTTP Request Headers:</li>
        <table border="1" style="border-collapse:collapse;">
            <tr>
                <th>Key</th>
                <th>Value</th>
            </tr>
            <tr>
                <td>"API-Version"</td>
                <td>"v1"</td>
            </tr>
        </table>
        <p>※"v1"を他の文字列で置き換えると <code>EndPoint.APIVersion.InitializationError</code>
            エラーになります；またこのヘッダーを省略すること自体は可能ですが、将来API仕様が変わる可能性があるため、入れることをお勧めします。</p>

        <li>HTTP Body:</li>
        <table border="1" style="border-collapse:collapse;">
            <tr>
                <th>Key</th>
                <th>Type</th>
                <th>Description</th>
                <th>Sample Value</th>
            </tr>
            <tr>
                <td>"name"</td>
                <td>String</td>
                <td>占う人の名前</td>
                <td>"錦木千束"</td>
            </tr>
            <tr>
                <td>"birthday"</td>
                <td>YearMonthDay（後述）</td>
                <td>占う人の生年月日</td>
                <td>-</td>
            </tr>
            <tr>
                <td>"blood_type"</td>
                <td>String</td>
                <td>占う人の血液型</td>
                <td>"ab"</td>
            </tr>
            <tr>
                <td>"today"</td>
                <td>YearMonthDay（後述）"</td>
                <td>今日の日付</td>
                <td>-</td>
            </tr>
        </table>

        <p>YearMonthDay 型の仕様：</p>
        <table border="1" style="border-collapse:collapse;">
            <tr>
                <th>Key</th>
                <th>Type</th>
                <th>Description</th>
                <th>Sample Value</th>
            </tr>
            <tr>
                <td>"year"</td>
                <td>Int</td>
                <td>年</td>
                <td>2004</td>
            </tr>
            <tr>
                <td>"month"</td>
                <td>Int</td>
                <td>月</td>
                <td>9</td>
            </tr>
            <tr>
                <td>"day"</td>
                <td>Int</td>
                <td>日</td>
                <td>23</td>
            </tr>
        </table>

        <p>JSON サンプル</p>
        <pre>
            <code>
            {
                "name": "錦木千束",
                "birthday": {
                    "year": 2004,
                    "month": 9,
                    "day": 23
                },
                "blood_type": "ab",
                "today": {
                    "year": 2022,
                    "month": 7,
                    "day": 2
                }
            }
            </code>
        </pre>

        <li>Response Body</li>
        <table border="1" style="border-collapse:collapse;">
            <tr>
                <th>Key</th>
                <th>Type</th>
                <th>Description</th>
                <th>Sample Value</th>
            </tr>
            <tr>
                <td>"name"</td>
                <td>String</td>
                <td>都道府県の名前</td>
                <td>"福井県"</td>
            </tr>
            <tr>
                <td>"capital"</td>
                <td>String</td>
                <td>県庁所在地</td>
                <td>"福井市"</td>
            </tr>
            <tr>
                <td>"citizen_day"</td>
                <td>MonthDay?（後述）</td>
                <td>県民の日（もしあれば）</td>
                <td>-</td>
            </tr>
            <tr>
                <td>"has_coast_line"</td>
                <td>Bool</td>
                <td>海岸線があるかどうか</td>
                <td>true</td>
            </tr>
            <tr>
                <td>"logo_url"</td>
                <td>String</td>
                <td>ロゴのURL</td>
                <td>"https://japan-map.com/wp-content/uploads/fukui.png"</td>
            </tr>
            <tr>
                <td>"brief"</td>
                <td>String</td>
                <td>都道府県の概要</td>
                <td>"福井県（ふくいけん）は、日本の中部地方に位置する県。県庁所在地は福井市。\n北陸地方で最も人口が少ない県である。\n※出典: フリー百科事典『ウィキペディア（Wikipedia）』"</td>
            </tr>
        </table>

        <p>MonthDay 型の仕様：</p>
        <table border="1" style="border-collapse:collapse;">
            <tr>
                <th>Key</th>
                <th>Type</th>
                <th>Description</th>
                <th>Sample Value</th>
            </tr>
            <tr>
                <td>"month"</td>
                <td>Int</td>
                <td>月</td>
                <td>9</td>
            </tr>
            <tr>
                <td>"day"</td>
                <td>Int</td>
                <td>日</td>
                <td>23</td>
            </tr>
        </table>

        <p>JSON サンプル</p>
        <pre>
            <code>
                {
                    "name": "福井県",
                    "brief": "福井県（ふくいけん）は、日本の中部地方に位置する県。県庁所在地は福井市。\n北陸地方で最も人口が少ない県である。\n※出典: フリー百科事典『ウィキペディア（Wikipedia）』",
                    "capital": "福井市"
                    "citizen_day": {
                        "month": 2,
                        "day": 7
                    },
                    "has_coast_line": true,
                    "logo_url": "https://japan-map.com/wp-content/uploads/fukui.png"
                }
            </code>
        </pre>
    </ul>

    <h3>環境</h3>
    <ul>
        <li>IDE：基本最新の安定版（本概要更新時点では Xcode 14.2）</li>
        <li>Swift：基本最新の安定版（本概要更新時点では Swift 5.7）</li>
        <li>開発ターゲット：基本最新の安定版（本概要更新時点では iOS 16.2）</li>
    </ul>

    <h3>動作</h3>
    <ol>
        <li>ユーザから名前、生年月日及び血液型を入力してもらいます。</li>
        <li>上記のデータと併せて、送信時の日付も一緒に入れて、上記の API に問い合わせてください。</li>
        <li>結果をもらったらその結果を表示してください。</li>
    </ol>

    <h3>注意点</h3>
    <ol>
        <li>必ず git でプロジェクトを管理し、git ホスティングサービスで提出してください。</li>
        <ol>
            <li>ホスティングサービスは GitHub 推奨です。ただし git リポジトリーをそのまま zip 化して提出することは NG です。</li>
            <li>git で提出してもらう理由は実装の途中経過を評価するためなので、いわゆるワンコミットの提出や、パッと全部やっつけた雑なコミットが含まれる提出物は評価できないため NG
                です。必ずコミット粒度を意識して作ってください。もちろんブランチ運用や PR 運用も高評価ポイントになります。</li>
            <li>GitHub で提出時に公開リポジトリーで提出したくない場合は、提出時にその旨をキャスターさんに伝えてください、コードチェック担当者の GitHub アカウントを返送しますので該当者に Read
                権限を付与してください。</li>
        </ol>
        <li>UI の指定はありませんが、UI/UX への考慮も評価ポイントになります。</li>
        <ol>
            <li>特に Dark Mode や横画面など、iOS がデフォルトで利用可能な機能について気をつけてください。例えば Dark Mode で文字が読めないような実装は減点ポイントになります。</li>
        </ol>
        <li>上記の動作さえ満たす限り、機能の追加等はウェルカムです。</li>
        <ol>
            <li>例：占い結果をローカルに保存する、iPad/Mac 対応、などなど。</li>
        </ol>
        <li>サードパーティーライブラリーの利用については、オープンソースのものに限り制限しません（むしろ推奨です）。</li>
        <ol>
            <li>CocoaPods と Carthage についても利用 OK ですが、SwiftPM の方を推奨します。</li>
        </ol>
        <li>SDK は UIKit および SwiftUI どちらでも OK です。</li>
        <ol>
            <li>両方の混在も OK です。</li>
        </ol>
    </ol>

    <h2>参考記事</h2>
    <p>提出された課題の評価ポイントに関しては、<a href="https://qiita.com/lovee/items/d76c68341ec3e7beb611">こちらの記事</a>に詳しく書かれてありますので、ぜひご覧ください。
    </p>
    <p>ライブラリの利用に関しては <a href="https://qiita.com/ykws/items/b951a2e24ca85013e722">こちらの記事</a>も参照ください。</p>
    </body>
    </head>
    """#
